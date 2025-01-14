import 'package:flutter/material.dart';

abstract class RegisterNavigator {
  /// actions betwwen view and viewmodel

  void showMyLoading();
  void hideMyLoading();
  void showMyMessage(
    String message, {
    String titleMessage ,
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
  });
}
