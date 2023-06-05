import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyles(double? size, Color? color, FontWeight? fw) {
  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: fw);
}

// more props are needed, just add them here
TextStyle appStyleWithMoreProps(
    double? size, Color? color, FontWeight? fw, Color? backgroundColor) {
  return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fw,
      backgroundColor: backgroundColor);
}
