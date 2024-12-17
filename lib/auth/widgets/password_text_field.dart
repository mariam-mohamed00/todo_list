import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  PasswordTextFormField(
      {required this.controller,
      this.onChanged,
      this.onTap,
      required this.errMsg,
      required this.label});

  final TextEditingController controller;
  final String? Function(String?)? onChanged;
  final void Function()? onTap;
  final String? errMsg;
  final String label;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isObscure = true;
  late String? _errorMessage = widget.errMsg;

  @override
  void didUpdateWidget(covariant PasswordTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _errorMessage = widget.errMsg;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: TextFormField(
        onChanged: widget.onChanged,
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
          errorText: _errorMessage,
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
        controller: widget.controller,
        obscureText: _isObscure,
        autocorrect: false,
        enableSuggestions: false,
        onTapOutside: (_) => setState(() {
          FocusScope.of(context).unfocus();
          _errorMessage = null;
        }),
        onTap: () {
          _errorMessage = widget.errMsg;
          widget.onTap?.call();
        },
      ),
    );
  }
}
