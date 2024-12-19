import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(color: MyTheme.primaryLight),
              Text(message)
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context,
    String contentMessage, {
    String titleMessage = '',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(negActionName)));
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleMessage),
          content: Text(contentMessage),
          actions: actions,
        );
      },
    );
  }
}
