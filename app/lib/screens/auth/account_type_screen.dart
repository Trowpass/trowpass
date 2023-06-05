// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/app_styles.dart';

class AccountTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Get Started as a',
              style: appStyles(20, Colors.black, FontWeight.w500),
            ),
            SizedBox(height: 32),
             StandardButtonOutline(
              color: primaryColor,
              text: 'Business',
              onPressed: () {
                // Handle business button press
              },
            ),
            SizedBox(height: 16),
             StandardButton(
              text: 'Individual',
              onPressed: () {
                // Handle individual button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
