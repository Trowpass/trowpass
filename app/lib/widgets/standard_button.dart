import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import '../shareds/utils/app_colors.dart';
import '../shareds/utils/border_radius.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final color;
  const StandardButton(
      {super.key, required this.text, required this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          backgroundColor: secondaryColor,
          minimumSize: const Size(double.infinity, 70),
          side: const BorderSide(color: secondaryColor),
        ),
        child: Text(
          text,
          style: appStyles(16, color ?? Colors.white, FontWeight.bold),
        ),
      ),
    );
  }
}

class StandardButtonOutline extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final color;
  const StandardButtonOutline(
      {super.key, required this.text, required this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          side: BorderSide(
            color:
                secondaryColor, // Apply border color or transparent if not provided
          ),
          backgroundColor: background,
          minimumSize: const Size(double.infinity, 70),
        ),
        child: Text(
          text,
          style: appStyles(16, color ?? Colors.white, FontWeight.w600),
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 70),
          side: const BorderSide(color: primaryColor),
      ),
    );
  }
}
