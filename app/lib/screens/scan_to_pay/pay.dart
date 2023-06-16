// ignore_for_file: prefer_const_constructors

import 'package:app/controllers/pay_screen_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0.0,
          title: Text(
            "Pay",
            style: appStyles(18, titleActive, FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            )
          ],
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
            child: Column(
              children: [
                const SizedBox(height: 12),
                PayForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PayForm extends StatelessWidget {
  final payController = Get.put(PayController());
  PayForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: payController.formKey,
        child: Column(
          children: [
            LabelText(textLabel: "Phone Number"),
            const SizedBox(height: 10),
            TextInputForm(
              enabled: false,
              inputController: payController.phoneNumberController,
              textLabel: '08134678957462',
              textHint: '08134678957462',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Full Name"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: false,
              inputController: payController.fullNameController,
              textLabel: 'Abosede Bright',
              textHint: 'Abosede Bright',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Amount"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: payController.amountController,
              // textLabel: 'Amount',
              textHint: 'N1200',
              validatorMessage: 'Please enter an amount',
              isPassword: true,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "PIN"),
            const SizedBox(height: 16),
            TextInputForm(
                enabled: true,
                inputController: payController.pinController,
                // textLabel: 'Pin',
                textHint: '0000',
                validatorMessage: 'Enter your pin',
                isPassword: true,
                autoCorrect: false),
            const SizedBox(height: 25),
            StandardButton(
              text: 'Continue to Pay',
              onPressed: () {
                if (payController.formKey.currentState!.validate()) {
                  payController.trySubmit();
                }
              },
            ),
          ],
        ));
  }
}
