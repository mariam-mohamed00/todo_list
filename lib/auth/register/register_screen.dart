// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/model/my_user.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/dialog_utils.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                    CustomTextFormField(
                        label: AppLocalizations.of(context)!.user_name,
                        onChanged: (text) {
                          setState(() {
                            if (text != null) name = text;
                          });
                          return null;
                        },
                        validator: (text) {
                          if (text!.isEmpty || text.length < 3) {
                            return AppLocalizations.of(context)!.invalid_name;
                          }
                          return null;
                        }),
                    CustomTextFormField(
                      onChanged: (text) {
                        setState(() {
                          if (text != null) email = text;
                        });
                        return null;
                      },
                      label: AppLocalizations.of(context)!.email,
                      textInputType: TextInputType.emailAddress,
                      validator: (text) {
                        if (!emailValid.hasMatch(text!)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: AppLocalizations.of(context)!.password,
                      onChanged: (text) {
                        setState(() {
                          if (text != null) password = text;
                        });
                        return null;
                      },
                      validator: (text) {
                        if (text!.length < 8) {
                          return AppLocalizations.of(context)!.invalid_password;
                        }
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: AppLocalizations.of(context)!.confirm_pass,
                      onChanged: (text) {
                        setState(() {
                          if (text != null) confirmPassword = text;
                        });
                        return null;
                      },
                      validator: (text) {
                        if (text != password) {
                          return AppLocalizations.of(context)!.confirm_errMsg;
                        }
                        return null;
                      },
                    ),
                    (name.length >= 3 &&
                            emailValid.hasMatch(email) &&
                            password.length >= 8 &&
                            password == confirmPassword)
                        ? DefaultElevatedButton(
                            isDisabled: false,
                            backgroundColor: MyTheme.primaryLight,
                            label: AppLocalizations.of(context)!.register,
                            onPressed: () {
                              setState(() {});
                              register();
                            },
                          )
                        : DefaultElevatedButton(
                            isDisabled: true,
                            label: AppLocalizations.of(context)!.register,
                            onPressed: () {},
                          ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.loginScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.already_have_an_account,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: MyTheme.primaryLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void register() async {
    var authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    DialogUtils.showLoading(
        context,
        AppLocalizations.of(context)!.loading,
        provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.backgroundDark);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      MyUser myUser =
          MyUser(id: credential.user?.uid ?? '', name: name, email: email);
      print(name);
      print('---------------------------');
      await FirebaseUtils.addUserToFireStore(myUser);
      authProvider.updateUser(myUser);

      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
          textColor: provider.appTheme == ThemeMode.light
              ? MyTheme.blackColor
              : MyTheme.whiteColor,
          actionColor: MyTheme.primaryLight,
          backgroundColor: provider.appTheme == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.backgroundDark,
          context,
          AppLocalizations.of(context)!.register_successfully, posAction: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
          posActionName: AppLocalizations.of(context)!.ok,
          titleMessage: AppLocalizations.of(context)!.success);
      print('register success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          textColor: provider.appTheme == ThemeMode.light
              ? MyTheme.blackColor
              : MyTheme.whiteColor,
          actionColor: MyTheme.primaryLight,
          backgroundColor: provider.appTheme == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.backgroundDark,
          context,
          'weak password',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          textColor: provider.appTheme == ThemeMode.light
              ? MyTheme.blackColor
              : MyTheme.whiteColor,
          actionColor: MyTheme.primaryLight,
          backgroundColor: provider.appTheme == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.backgroundDark,
          context,
          AppLocalizations.of(context)!.email_already_in_use,
          negActionName: AppLocalizations.of(context)!.ok,
          titleMessage: AppLocalizations.of(context)!.try_again,
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
