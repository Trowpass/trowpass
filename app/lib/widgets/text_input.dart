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
  const TextInput({
    Key? key,
    required this.inputController,
    this.textLabel,
    this.textHint,
    required this.isPassword,
    required this.isReadOnly,
    this.maxLength,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      readOnly: isReadOnly,
      obscureText: isPassword,
      autocorrect: isPassword == false ? true : false,
      controller: inputController,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: grayscale),
          ),
          labelText: textLabel,
          hintText: textHint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius))),
    );
  }
}
