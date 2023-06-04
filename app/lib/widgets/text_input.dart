import 'package:flutter/material.dart';

import '../shareds/utils/border_radius.dart';

class TextInput extends StatelessWidget {
  final TextEditingController inputController;
  final String textLabel;
  final String textHint;
  final bool isPassword;
  const TextInput({
    Key? key,
    required this.inputController,
    required this.textLabel,
    required this.textHint,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      autocorrect: isPassword == false ? true : false,
      controller: inputController,
      decoration: InputDecoration(
          labelText: textLabel,
          hintText: textHint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius))),
    );
  }
}
