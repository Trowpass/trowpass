// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:app/screens/get_transport_card/card_type.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetTransportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Get Transport Card',
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Instantly get a virtual card to make tranport payment easily on your favourite transport app",
                    style: appStyles(14, titleActive, FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(preview),
                const SizedBox(
                  height: 25,
                ),
                StandardButton(
                  text: 'Create Virtual Card',
                  onPressed: () {
                    Get.to(CardTypeScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
