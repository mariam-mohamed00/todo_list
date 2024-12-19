import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';

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
          labelStyle:
              Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
          suffixIcon: IconButton(
            icon: Icon(
              color: MyTheme.blackColor,
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
