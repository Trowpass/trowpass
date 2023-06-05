// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:app/screens/auth/sign_up_screen_business.dart';
import 'package:app/screens/auth/sign_up_screen_individual.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class AccountTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
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
            SizedBox(height: 35),
            StandardButtonOutline(
              color: secondaryColor,
              text: 'Business',
              onPressed: () {
                Get.to(() => SignupScreenBusiness());
              },
            ),
            SizedBox(height: 18),
            StandardButton(
              text: 'Individual',
              onPressed: () {
                Get.to(() => SignupScreenIndividual());
              },
            ),
          ],
        ),
      ),
    );
  }
}
