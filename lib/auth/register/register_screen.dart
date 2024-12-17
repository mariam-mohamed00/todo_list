import 'package:app_todo_list/auth/widgets/custom_text_form_field%20copy.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmationPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String errEmailMsg = '';
  String errNameMsg = '';
  String errPassMsg = '';
  String errConfirmPassMsg = '';

  @override
  Widget build(BuildContext context) {
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
                      onTap: () => setState(() {
                        if (nameController.text.length < 3) {
                          errNameMsg = 'Invaled name';
                        } else {
                          errNameMsg = '';
                        }
                        errEmailMsg = '';
                        errPassMsg = '';
                        errConfirmPassMsg = '';
                      }),
                      errMsg: errNameMsg,
                      label: 'User Name',
                      controller: nameController,
                      onChanged: (text) {
                        setState(() {
                          if (nameController.text.length < 3) {
                            errNameMsg = 'Invalid name';
                          } else {
                            errNameMsg = '';
                          }
                        });
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      onTap: () => setState(() {
                        if (!emailValid.hasMatch(emailController.text)) {
                          errEmailMsg = 'Invaled email';
                        } else {
                          errEmailMsg = '';
                        }
                        errNameMsg = '';
                        errPassMsg = '';
                        errConfirmPassMsg = '';
                      }),
                      errMsg: errEmailMsg,
                      onChanged: (text) {
                        setState(() {
                          if (!emailValid.hasMatch(text.toString())) {
                            errEmailMsg = 'Invalid email';
                          } else {
                            errEmailMsg = '';
                          }
                        });
                        return null;
                      },
                      label: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    PasswordTextFormField(
                      label: 'Password',
                      errMsg: errPassMsg,
                      controller: passwordController,
                      onTap: () => setState(() {
                        if (passwordController.text.length < 6) {
                          errPassMsg = 'Invalid password';
                        } else {
                          errPassMsg = '';
                        }
                        errNameMsg = '';
                        errEmailMsg = '';
                        errConfirmPassMsg = '';
                      }),
                      onChanged: (text) {
                        setState(() {
                          if (text.toString().length < 6) {
                            errPassMsg = 'Invalid password';
                          } else {
                            errPassMsg = '';
                          }
                        });
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: 'Confirmation Password',
                      errMsg: errConfirmPassMsg,
                      controller: confirmationPasswordController,
                      onTap: () => setState(() {
                        if (confirmationPasswordController.text !=
                            passwordController.text) {
                          errConfirmPassMsg = "Password doesn't match";
                        } else {
                          errConfirmPassMsg = '';
                        }
                        errNameMsg = '';
                        errEmailMsg = '';
                        errPassMsg = '';
                      }),
                      onChanged: (text) {
                        setState(() {
                          if (text != passwordController.text) {
                            errConfirmPassMsg = "Password doesn't match";
                          } else {
                            errConfirmPassMsg = '';
                          }
                        });
                        return null;
                      },
                    ),
                    (nameController.text.length >= 3 &&
                            emailValid.hasMatch(emailController.text) &&
                            passwordController.text.length >= 6 &&
                            confirmationPasswordController.text ==
                                passwordController.text)
                        ? DefaultElevatedButton(
                            isDisabled: false,
                            backgroundColor: MyTheme.primaryLight,
                            label: 'Register',
                            labelColor: MyTheme.whiteColor,
                            onPressed: () {
                              setState(() {});
                              Navigator.of(context).pushReplacementNamed(
                                Routes.home,
                              );
                            },
                          )
                        : DefaultElevatedButton(
                            isDisabled: true,
                            label: 'Register',
                            onPressed: () {},
                          ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.loginScreen);
                        },
                        child: Text(
                          'Already have an account',
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

  void register() {
    // if (formKey.currentState?.validate() == true) {
    if (nameController.text.length >= 3 &&
        emailValid.hasMatch(emailController.text) &&
        passwordController.text.length >= 6 &&
        confirmationPasswordController.text == passwordController.text) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }
}
