import 'package:flutter/material.dart';

abstract class LoginNavigator {
  void showMyLoading();
  void hideMyLoading();
  void showMyMessage(String message,
      {String titleMessage,
      VoidCallback? posAction,
      String? posActionName,
      String? negActionName});
}
