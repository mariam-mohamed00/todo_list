// ignore_for_file: avoid_print

import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_todo_list/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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
                      label: AppLocalizations.of(context)!.email,
                      textInputType: TextInputType.emailAddress,
                      validator: (text) {
                        if (!emailValid.hasMatch(text!)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          if (text != null) email = text;
                        });
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: AppLocalizations.of(context)!.password,
                      validator: (text) {
                        if (text!.length < 8) {
                          return AppLocalizations.of(context)!.invalid_password;
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          if (text != null) password = text;
                        });
                        return null;
                      },
                    ),
                    (emailValid.hasMatch(email) && password.length >= 8)
                        ? DefaultElevatedButton(
                          labelColor: MyTheme.whiteColor,
                            isDisabled: false,
                            backgroundColor: MyTheme.primaryLight,
                            label: AppLocalizations.of(context)!.login,
                            onPressed: () {
                              setState(() {});
                              login();
                            },
                          )
                        : DefaultElevatedButton(
                            isDisabled: true,
                            label: AppLocalizations.of(context)!.login,
                            onPressed: () {},
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5),
                        Text(
                          AppLocalizations.of(context)!.do_not_have_an_account,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.registerScreen);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: TextStyle(
                                  color: MyTheme.primaryLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void login() async {
    DialogUtils.showLoading(
        context,
        AppLocalizations.of(context)!.loading,
        provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.backgroundDark);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('Before read user from Firestore');
      print('----------------------------------------------------');

      var user =
          await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? "");
      if (user == null) {
        return;
      }

      var authProvider = Provider.of<UserAuthProvider>(context, listen: false);
      authProvider.updateUser(user);

      DialogUtils.hideLoading(context);

      DialogUtils.showMessage(
        context,
        AppLocalizations.of(context)!.login_successfully,
        posAction: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        posActionName: AppLocalizations.of(context)!.ok,
        titleMessage: AppLocalizations.of(context)!.success,
        textColor: provider.appTheme == ThemeMode.light
            ? MyTheme.blackColor
            : MyTheme.whiteColor,
        actionColor: MyTheme.primaryLight,
        backgroundColor: provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.backgroundDark,
      );
      print('login success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
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
          AppLocalizations.of(context)!.user_not_found,
          negActionName: AppLocalizations.of(context)!.ok,
          titleMessage: AppLocalizations.of(context)!.try_again,
        );

        print(e);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
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
          'wrong password',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );
        print('Wrong password provided for that user.');
      } else {
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
          AppLocalizations.of(context)!.user_not_found,
          negActionName: AppLocalizations.of(context)!.ok,
          titleMessage: AppLocalizations.of(context)!.try_again,
        );
      }
    }
  }
}
