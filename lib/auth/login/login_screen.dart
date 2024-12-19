// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/widgets/custom_text_form_field.dart';
import 'package:app_todo_list/auth/widgets/default_elevation_button.dart';
import 'package:app_todo_list/auth/widgets/password_text_field.dart';
import 'package:app_todo_list/dialog_utils.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                      label: 'Email',
                      textInputType: TextInputType.emailAddress,
                      validator: (text) {
                        if (!emailValid.hasMatch(text!)) {
                          return 'Invalid email';
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
                      label: 'Password',
                      validator: (text) {
                        if (text!.length < 8) {
                          return 'Invalid password';
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
                            isDisabled: false,
                            backgroundColor: MyTheme.primaryLight,
                            label: 'Login',
                            labelColor: MyTheme.whiteColor,
                            onPressed: () {
                              setState(() {});
                              login();
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

  void login() async {
    DialogUtils.showLoading(context, 'Loading...');
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context, 'Login successfully', posAction: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }, posActionName: 'Ok', titleMessage: 'Success');
      print('login success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          'user not found',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );
        print(e);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          'wrong password',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );
        print('Wrong password provided for that user.');
      } else {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          'user not found or wrong password',
          negActionName: 'ok',
          titleMessage: 'Try again',
        );
      }
    }
  }
}
