import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';

class TransparentButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? icon;
  final String text;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;

  const TransparentButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.contentPadding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Container(
            padding: contentPadding,
            decoration: BoxDecoration(
              border: Border.all(color: greyLight.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Row(
              children: [
                Visibility(
                  visible: icon != null,
                  child: icon ?? Container(),
                ),
                Text(
                  text,
                  style: appStyles(16, titleActive, FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
