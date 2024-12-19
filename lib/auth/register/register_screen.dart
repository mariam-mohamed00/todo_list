// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/dialog_utils.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                        label: 'User Name',
                        onChanged: (text) {
                          setState(() {
                            if (text != null) name = text;
                          });
                          return null;
                        },
                        validator: (text) {
                          if (text!.isEmpty || text.length < 3) {
                            return 'invalid name';
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
                      label: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      validator: (text) {
                        if (!emailValid.hasMatch(text!)) {
                          return 'invalid email';
                        }
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: 'Password',
                      onChanged: (text) {
                        setState(() {
                          if (text != null) password = text;
                        });
                        return null;
                      },
                      validator: (text) {
                        if (text!.length < 8) {
                          return 'invalid password';
                        }
                        return null;
                      },
                    ),
                    PasswordTextFormField(
                      label: 'Confirmation Password',
                      onChanged: (text) {
                        setState(() {
                          if (text != null) confirmPassword = text;
                        });
                        return null;
                      },
                      validator: (text) {
                        if (text != password) {
                          return "password doesn't match";
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
                            label: 'Register',
                            labelColor: MyTheme.whiteColor,
                            onPressed: () {
                              setState(() {});
                              register();
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

  void register() async {
    DialogUtils.showLoading(context, 'Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context, 'Register successfully', posAction: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }, posActionName: 'Ok', titleMessage: 'Success');
      print('register success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          'weak password',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          'email already in use',
          negActionName: 'Ok',
          titleMessage: 'Try again',
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
