// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/login/login_navigator.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreenViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  late AppConfigProvider provider;

  late LoginNavigator navigator;

  void login(BuildContext context) async {
    navigator.showMyLoading();

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

      navigator.hideMyLoading();

      navigator.showMyMessage(
        AppLocalizations.of(context)!.login_successfully,
        titleMessage: AppLocalizations.of(context)!.success,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      );

      print('login success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideMyLoading();

        navigator.showMyMessage(
          AppLocalizations.of(context)!.user_not_found,
          titleMessage: AppLocalizations.of(context)!.try_again,
          negActionName: AppLocalizations.of(context)!.ok,
        );

        print(e);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideMyLoading();

        navigator.showMyMessage(
          'wrong password',
          titleMessage: AppLocalizations.of(context)!.try_again,
          negActionName: AppLocalizations.of(context)!.ok,
        );

        print('Wrong password provided for that user.');
      } else {
        navigator.hideMyLoading();

        navigator.showMyMessage(
          AppLocalizations.of(context)!.user_not_found,
          titleMessage: AppLocalizations.of(context)!.try_again,
          negActionName: AppLocalizations.of(context)!.ok,
        );
      }
    }
  }
}