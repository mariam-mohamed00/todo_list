import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.height,
      this.width,
      this.isDisabled = false,
      this.backgroundColor,
      this.labelColor});

  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? labelColor;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    final screenSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.transparent
                  : MyTheme.primaryLight),
          fixedSize: Size(
            width ?? screenSize.width,
            height ?? screenSize.height * 0.06,
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: labelColor),
        ),
      ),
    );
  }
}
