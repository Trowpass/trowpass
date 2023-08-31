import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';
import '../shareds/utils/border_radius.dart';
import 'app_styles.dart';

class StandardButtonOutline extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
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
            side: const BorderSide(
              color:
                  primaryColor, // Apply border color or transparent if not provided
            ),
            backgroundColor: background,
            minimumSize: const Size(double.infinity, 70),
          ),
          child: Text(
            text,
            style: appStyleWithMoreProps(16, color, FontWeight.w500, null),
          ),
        ));
  }
}
