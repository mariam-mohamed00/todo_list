// ignore_for_file: avoid_print

import 'package:app_todo_list/auth/register/register_navigator.dart';
import 'package:app_todo_list/model/my_user.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

interface class RegisterScreenViewModel extends ChangeNotifier {
  /// hold data - handle logic

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late AppConfigProvider provider;

  var formKey = GlobalKey<FormState>();

  late RegisterNavigator registerNavigator;

  void register(BuildContext context) async {
    var authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    registerNavigator.showMyLoading();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      MyUser myUser =
          MyUser(id: credential.user?.uid ?? '', name: name, email: email);
      print(name);
      print('---------------------------');
      await FirebaseUtils.addUserToFireStore(myUser);
      authProvider.updateUser(myUser);

      registerNavigator.hideMyLoading();

      registerNavigator.showMyMessage(
        AppLocalizations.of(context)!.register_successfully,
        titleMessage: AppLocalizations.of(context)!.success,
        posActionName: AppLocalizations.of(context)!.ok,
        posAction: () =>
            Navigator.of(context).pushReplacementNamed(Routes.home),
      );

      print('register success');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        registerNavigator.hideMyLoading();
        registerNavigator.showMyMessage(
          'weak password',
          titleMessage: AppLocalizations.of(context)!.try_again,
          negActionName: AppLocalizations.of(context)!.ok,
        );

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        registerNavigator.hideMyLoading();

        registerNavigator.showMyMessage(
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