// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shareds/utils/app_colors.dart';
import '../shareds/utils/border_radius.dart';

class TextInputForm extends StatelessWidget {
  final TextEditingController inputController;
  final String? textLabel;
  final String? textHint;
  final String? textError;
  final String? validatorMessage;
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
  final bool enabled; // Added the enabled field
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const TextInputForm({
    Key? key,
    required this.inputController,
    this.textLabel,
    this.textHint,
    this.textError,
    this.validatorMessage,
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
    required this.enabled,
    this.inputFormatters, // Added the enabled parameter
    this.validator,
    String? initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fillColor = enabled ? Colors.transparent : filled;
    // final borderColor = enabled ? border : border;

    return TextFormField(
      inputFormatters: inputFormatters,
      keyboardType: inputType,
      obscureText: isPassword,
      autocorrect: autoCorrect,
      controller: inputController,
      style: const TextStyle(fontSize: 15),
      enabled:
          enabled, // Use the enabled parameter to enable or disable the input field
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
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: border),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: border),
        ),
        filled: true,
        fillColor: fillColor,
      ),
      validator: validator ??
          (value) {
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
