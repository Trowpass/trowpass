// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shareds/utils/app_colors.dart';

class CardCreatedScreen extends StatelessWidget {
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
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  cardSuccess,
                ),
                const SizedBox(height: 20),
                Text(
                  'Congratulations your card has been created!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: spacing),
                StandardButton(
                  text: 'Done',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
