import 'package:app_todo_list/auth/register/register_navigator.dart';
import 'package:app_todo_list/auth/register/register_screen_view_model.dart';
import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/dialog_utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.registerNavigator = this;
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
                          label: AppLocalizations.of(context)!.user_name,
                          onChanged: (text) {
                            setState(() {
                              if (text != null) viewModel.name = text;
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
                            if (text != null) viewModel.email = text;
                          });
                          return null;
                        },
                        label: AppLocalizations.of(context)!.email,
                        textInputType: TextInputType.emailAddress,
                        validator: (text) {
                          if (!viewModel.emailValid.hasMatch(text!)) {
                            return AppLocalizations.of(context)!.invalid_email;
                          }
                          return null;
                        },
                      ),
                      PasswordTextFormField(
                        label: AppLocalizations.of(context)!.password,
                        onChanged: (text) {
                          setState(() {
                            if (text != null) viewModel.password = text;
                          });
                          return null;
                        },
                        validator: (text) {
                          if (text!.length < 8) {
                            return AppLocalizations.of(context)!
                                .invalid_password;
                          }
                          return null;
                        },
                      ),
                      PasswordTextFormField(
                        label: AppLocalizations.of(context)!.confirm_pass,
                        onChanged: (text) {
                          setState(() {
                            if (text != null) viewModel.confirmPassword = text;
                          });
                          return null;
                        },
                        validator: (text) {
                          if (text != viewModel.password) {
                            return AppLocalizations.of(context)!.confirm_errMsg;
                          }
                          return null;
                        },
                      ),
                      (viewModel.name.length >= 3 &&
                              viewModel.emailValid.hasMatch(viewModel.email) &&
                              viewModel.password.length >= 8 &&
                              viewModel.password == viewModel.confirmPassword)
                          ? DefaultElevatedButton(
                              isDisabled: false,
                              labelColor: MyTheme.whiteColor,
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
                            AppLocalizations.of(context)!
                                .already_have_an_account,
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
      ),
    );
  }

  void register() async {
    viewModel.register(context);
  }

  @override
  void hideMyLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(
        context,
        AppLocalizations.of(context)!.loading,
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
