import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';
import '../shareds/utils/border_radius.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const StandardButton(
      {super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 70),
          side: const BorderSide(color: primaryColor),
        ),
        child: Text(
          text,
          style: appStyles(22, Colors.white, FontWeight.bold),
        ),
      ),
    );
  }
}
