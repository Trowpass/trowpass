// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/controllers/rider/card_type_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CardTypeScreen extends StatelessWidget {
  final controller = Get.put(CardTypeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
        isLoading: controller.isLoading.value,
        overlayBackgroundColor: background,
        progressColor: primaryColor,
        child: Scaffold(
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
            centerTitle: true,
            title: Text(
              'What type of card do you want?',
              style: appStyles(18, titleActive, FontWeight.w600),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardBox(
                  icon: Icon(
                    Icons.credit_card,
                    color: primaryColor,
                  ),
                  title: 'Virtual Debit Card',
                  description:
                      'Instantly create a virtual card to spend on transport fare.',
                  onPressed: controller.isVirtualCreated.value
                      ? controller.handleVirtualCardDetains
                      : controller.createVirtualCard,
                ),
                CardBox(
                  icon: Icon(
                    Icons.credit_card,
                    color: primaryColor,
                  ),
                  title: 'Physical Debit Card',
                  description:
                      'Get a physical card to spend on transports anytime and anywhere.',
                  onPressed: controller.handlePhysicalCardPressed,
                ),
              ],
            ),
          ),
        )));
  }
}

class CardBox extends StatelessWidget {
  final controller = Get.put(CardTypeController());
  final Icon icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  CardBox({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: primaryColor.withOpacity(0.2),
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: borderRadius,
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
                      onPressed: onPressed,
                      child: Text(
                        controller.isVirtualCreated.value
                            ? 'Get Details'
                            : 'Get Started',
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
      ),
    );
  }
}
