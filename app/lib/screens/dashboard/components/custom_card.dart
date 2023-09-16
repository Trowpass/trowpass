// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
class CustomCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const CustomCard({
    required this.imagePath,
    required this.text,
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          // height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(cardBorderRadius),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     // blurRadius: 5,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 12),
              Image.asset(imagePath),
              SizedBox(height: 12),
              Flexible(
                child: Text(
                  text,
                  style: appStyles(
                    9,
                    titleActive,
                    FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}