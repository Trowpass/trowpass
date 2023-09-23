import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String textLabel;
  const LabelText({
    super.key,
    required this.textLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Align
    (
      alignment: Alignment.topLeft,
      child: Text(
          textLabel,
          style: appStyles(
            15,
            label,
            FontWeight.w400,
          ),
        ),
    );
  }
}
