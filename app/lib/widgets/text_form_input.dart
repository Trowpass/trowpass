// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/app_styles.dart';

class TextInputForm extends StatefulWidget {
  final TextEditingController inputController;
  final String textLabel;
  final String textHint;
  final String? textError;
  final String validatorMessage;
  final bool isPassword;
  final bool autoCorrect;
  final Widget? prefixIcon;
  final TextInputType? inputType;

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
    this.inputType,
  }) : super(key: key);

  @override
  _TextInputFormState createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        _isFocused ? const Color(0xFF0122AE) : const Color(0xFFA0A3BD);

    return TextFormField(
      keyboardType: widget.inputType,
      obscureText: widget.isPassword && !_showPassword,
      autocorrect: widget.autoCorrect,
      controller: widget.inputController,
      style: const TextStyle(fontSize: 16, color: grayscale, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon, prefixIconColor: _isFocused ? const Color(0xFF0122AE) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: _isFocused ? const Color(0xFF0122AE) : null,
                ),
              )
            : (widget.inputController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      widget.inputController.clear();
                    },
                    icon: Icon(Icons.cancel,
                        color: _isFocused ? const Color(0xFF0122AE) : null),
                  )
                : null),
        labelText: widget.textLabel,
        labelStyle: appStyles(15, _isFocused ? const Color(0xFF0122AE) : null, null),
        hintText: widget.textHint, 
        errorText: widget.textError,
        errorStyle: appStyles(null, validationErrorColor, null),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: BorderSide(color: const Color(0xFF0122AE)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return widget.validatorMessage;
        }
        return null;
      },
      onChanged: (_) {
        setState(() {
          _isFocused = false;
        });
      },
      onTap: () {
        setState(() {
          _isFocused = true;
        });
      },
      onFieldSubmitted: (_) {
        setState(() {
          _isFocused = false;
        });
      },
    );
  }
}
