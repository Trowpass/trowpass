// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/inter_wallet_transfer_controller/payment_summary_controller.dart';

class InterWalletPaymentSummaryScreen extends StatelessWidget {
  final PaymentSummaryController paymentSummaryController = Get.put(PaymentSummaryController());

   @override
  Widget build(BuildContext context) {
    paymentSummaryController.initializeData();
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0.0,
          title: Text(
            "Payment Summary",
            style: appStyles(18, titleActive, FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Image.asset(summary),
                  const SizedBox(height: 18),
                  Obx(
                    () => Text(
                      paymentSummaryController.paymentMethod.value,
                      style: appStyles(20, titleActive, FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      paymentSummaryController.transactionId.value,
                      style: appStyles(16, titleActive, FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Text(
                      paymentSummaryController.amount.value,
                      style: appStyles(24, titleActive, FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 35),
                  StandardButton(
                    text: 'Pay Now',
                    onPressed: () {
                      paymentSummaryController.payNow();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
