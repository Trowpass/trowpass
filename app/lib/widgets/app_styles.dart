import 'package:flutter/material.dart';

TextStyle appStyles(double? size, Color? color, FontWeight? fw) {
  return TextStyle(fontSize: size, color: color, fontWeight: fw);
}

TextStyle appStyleWithMoreProps(
    double? size, Color? color, FontWeight? fw, Color? backgroundColor) {
  return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fw,
      backgroundColor: backgroundColor);
}
