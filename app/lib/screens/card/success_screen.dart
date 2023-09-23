import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shareds/utils/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final String imageAsset;
  final VoidCallback onTap;

  // ignore: use_key_in_widget_constructors
  const SuccessScreen(
      {required this.message, required this.imageAsset, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double spacing = screenSize.height * 0.21;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarBrightness: Brightness.light, // For iOS
        statusBarIconBrightness: Brightness.light, // For Android
        systemNavigationBarColor: navigationBarBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageAsset),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: appStyles(16, null, FontWeight.w500),
                ),
                SizedBox(height: spacing),
                StandardButton(text: 'Done', onPressed: onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
