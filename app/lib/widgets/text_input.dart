import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/border_radius.dart';

class TextInput extends StatelessWidget {
  final TextEditingController inputController;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? textLabel;
  final String? textHint;
  final bool isPassword;
  final bool isReadOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  const TextInput({
    Key? key,
    required this.inputController,
    this.textLabel,
    this.textHint,
    required this.isPassword,
    required this.isReadOnly,
    this.maxLength,
    this.keyboardType,
    required this.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fillColor = enabled ? Colors.transparent : filled;
    final borderColor = enabled ? primaryColor : filled;
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      maxLength: maxLength,
      readOnly: isReadOnly,
      obscureText: isPassword,
      autocorrect: isPassword == false ? true : false,
      controller: inputController,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          labelText: textLabel,
          hintText: textHint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius))),
    );
  }
}
