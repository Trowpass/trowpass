// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/controllers/card_type_controller.dart';
import 'package:app/screens/get_transport_card/card_design.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CardTypeScreen extends StatelessWidget {
  final CardTypeController controller = Get.put(CardTypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        centerTitle: false,
        title: Text(
          'What type of card do you want?',
          style: appStyles(18, titleActive, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10),
            CardBox(
              icon: Icon(Icons.credit_card),
              title: 'Virtual Debit Card',
              description:
                  'Instantly create a virtual card to spend on transport fare.',
              onPressed: controller.handleVirtualCardPressed,
            ),
            CardBox(
              icon: Icon(Icons.credit_card),
              title: 'Physical Debit Card',
              description:
                  'Get a physical card to spend on transports anytime and anywhere.',
              onPressed: controller.handlePhysicalCardPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const CardBox({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    description,
                    style: appStyles(13, label, FontWeight.w400),
                  )),
                  TextButton(
                    onPressed: () {
                      Get.to(CardDesignScreen());
                    },
                    child: Text(
                      'Get Started',
                      style: appStyles(
                        13,
                        anchor,
                        FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
