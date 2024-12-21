import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.validator,
  });

  String label;
  TextInputType textInputType;
  String? Function(String?)? onChanged;
  String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // late FocusNode focusNode;

  // @override
  // void initState() {
  //   super.initState();

  //   focusNode = FocusNode();
  //   focusNode.addListener(() {
  //     setState(() {
  //       focusNode.hasFocus;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: TextFormField(
        // focusNode: focusNode,
        // validator: (value) {
        //   if (!focusNode.hasFocus) return null;
        //   return widget.validator?.call(value);
        // },
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        keyboardType: widget.textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: provider.appTheme == ThemeMode.light
            ? Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16)
            : Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 16, color: MyTheme.whiteColor),
        decoration: InputDecoration(
          labelStyle: provider.appTheme == ThemeMode.light
              ? Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16)
              : Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16, color: MyTheme.whiteColor),
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
