// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';
import '../shareds/utils/border_radius.dart';

// this input text is for validation form ony
class TextInputForm extends StatelessWidget {
  final TextEditingController inputController;
  final String textLabel;
  final String textHint;
  final String? textError;
  final String validatorMessage;
  final bool isPassword;
  final bool autoCorrect;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  const TextInputForm({
    Key? key,
    required this.inputController,
    required this.textLabel,
    required this.textHint,
    this.textError,
    required this.validatorMessage,
    required this.isPassword,
    required this.autoCorrect,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.enabledBorder,
    this.focusedBorder,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: isPassword,
      autocorrect: autoCorrect,
      controller: inputController,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: textLabel,
          labelStyle: appStyles(15, null, null),
          hintText: textHint,
          errorText: textError,
          errorStyle: appStyles(null, validationErrorColor, null),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: const BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: const BorderSide(color: primaryColor),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius))),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorMessage;
        }
        return null;
      },
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
