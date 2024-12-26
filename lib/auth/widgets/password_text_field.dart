import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    required this.label,
  });

  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String label;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _isObscure,
        autocorrect: false,
        enableSuggestions: false,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        style: provider.appTheme == ThemeMode.light
            ? Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16)
            : Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 16, color: MyTheme.whiteColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyTheme.primaryLight, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyTheme.primaryLight, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyTheme.primaryLight, width: 3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyTheme.primaryLight, width: 3),
          ),
          label: Text(widget.label),
          labelStyle: provider.appTheme == ThemeMode.light
              ? Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16)
              : Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16, color: MyTheme.whiteColor),
          suffixIcon: IconButton(
            icon: Icon(
              color: provider.appTheme == ThemeMode.light
                  ? MyTheme.blackColor
                  : MyTheme.whiteColor,
              _isObscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () => setState(() => _isObscure = !_isObscure),
          ),
        ),
      ),
    );
  }
}
