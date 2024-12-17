import 'package:app_todo_list/auth/widgets/custom_text_form_field%20copy.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String errEmailMsg = '';
  String errPasswordMsg = '';
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                      controller: emailController,
                      label: 'Email',
                      errMsg: errEmailMsg,
                      textInputType: TextInputType.emailAddress,
                      onTap: () {
                        setState(() {
                          if (!emailValid.hasMatch(emailController.text)) {
                            errEmailMsg = 'Invalid email';
                          } else {
                            errEmailMsg = '';
                          }
                          errPasswordMsg = '';
                        });
                      },
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
                    ),
                    PasswordTextFormField(
                      label: 'Password',
                      errMsg: errPasswordMsg,
                      controller: passwordController,
                      onTap: () => setState(() {
                        if (passwordController.text.length < 6) {
                          errPasswordMsg = 'Invalid password';
                        } else {
                          errPasswordMsg = '';
                        }
                        errEmailMsg = '';
                      }),
                      onChanged: (text) {
                        setState(() {
                          if (text.toString().length < 6) {
                            errPasswordMsg = 'Invalid password';
                          } else {
                            errPasswordMsg = '';
                          }
                        });
                        return null;
                      },
                    ),
                    (emailValid.hasMatch(emailController.text) &&
                            passwordController.text.length >= 6)
                        ? DefaultElevatedButton(
                            isDisabled: false,
                            backgroundColor: MyTheme.primaryLight,
                            label: 'Login',
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
                            label: 'Login',
                            onPressed: () {},
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5),
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.registerScreen);
                            },
                            child: Text(
                              'Sign up',
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
}
