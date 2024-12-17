import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.controller,
    required this.label,
    this.textInputType = TextInputType.text,
    required this.errMsg,
    this.onChanged,
    this.onTap,

    // this.validator,
  });

  TextEditingController controller;
  String label;
  TextInputType textInputType;
  String errMsg;
  String? Function(String?)? onChanged;
  void Function()? onTap;

  // String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late String? _errorMessage = widget.errMsg;

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _errorMessage = widget.errMsg;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: TextFormField(
        controller: widget.controller,

        // validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: () {
          _errorMessage = widget.errMsg;
          widget.onTap?.call();
        },
        onTapOutside: (_) {
          setState(() {
            FocusScope.of(context).unfocus();
            _errorMessage = null;
          });
        },
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          errorText: _errorMessage,
          labelStyle:
              Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
          label: Text(widget.label),
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
        ),
      ),
    );
  }
}
