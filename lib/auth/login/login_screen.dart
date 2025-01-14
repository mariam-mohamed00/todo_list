// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/login/login_navigator.dart';
import 'package:app_todo_list/auth/login/login_screen_view_model.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/dialog_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    viewModel.provider = Provider.of<AppConfigProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/main_background.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Form(
                key: viewModel.formKey,
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
                          if (!viewModel.emailValid.hasMatch(text!)) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                        onChanged: (text) {
                          setState(() {
                            if (text != null) viewModel.email = text;
                          });
                          return null;
                        },
                      ),
                      PasswordTextFormField(
                        label: AppLocalizations.of(context)!.password,
                        validator: (text) {
                          if (text!.length < 8) {
                            return AppLocalizations.of(context)!
                                .invalid_password;
                          }
                          return null;
                        },
                        onChanged: (text) {
                          setState(() {
                            if (text != null) viewModel.password = text;
                          });
                          return null;
                        },
                      ),
                      (viewModel.emailValid.hasMatch(viewModel.email) &&
                              viewModel.password.length >= 8)
                          ? DefaultElevatedButton(
                              labelColor: MyTheme.whiteColor,
                              isDisabled: false,
                              backgroundColor: MyTheme.primaryLight,
                              label: AppLocalizations.of(context)!.login,
                              onPressed: () {
                                setState(() {});
                                viewModel.login(context);
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
                            AppLocalizations.of(context)!
                                .do_not_have_an_account,
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
      ),
    );
  }

  @override
  void hideMyLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(
        context,
        AppLocalizations.of(context)!.waiting,
        viewModel.provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.backgroundDark);
  }

  @override
  void showMyMessage(String message,
      {String titleMessage = '',
      VoidCallback? posAction,
      String? posActionName,
      String? negActionName}) {
    DialogUtils.showMessage(
      context,
      message,
      posActionName: posActionName,
      negActionName: negActionName,
      posAction: posAction,
      titleMessage: titleMessage,
      textColor: viewModel.provider.appTheme == ThemeMode.light
          ? MyTheme.blackColor
          : MyTheme.whiteColor,
      actionColor: MyTheme.primaryLight,
      backgroundColor: viewModel.provider.appTheme == ThemeMode.light
          ? MyTheme.whiteColor
          : MyTheme.backgroundDark,
    );
  }
}
