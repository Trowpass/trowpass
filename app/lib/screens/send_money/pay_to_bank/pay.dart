// ignore_for_file: prefer_const_constructors
import 'package:app/controllers/pay_to_bank_controller/pay_screen_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/all_banks_list.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/overlay_indeterminate_progress.dart';

class PayToBankScreen extends StatelessWidget {
  PayToBankScreen({super.key});
  final payController = Get.put(PayToBankController());

  @override
  Widget build(BuildContext context) {
    payController.clearTextFields();
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: payController.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
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
                elevation: 0.0,
                title: Text(
                  "To Bank Account",
                  style: appStyles(18, titleActive, FontWeight.w600),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
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
          ),
        ));
  }
}

class PayForm extends StatelessWidget {
  final payController = Get.put(PayToBankController());
  PayForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: payController.formKey,
        child: Column(
          children: [
             LabelText(textLabel: "Bank Name"),
                 const SizedBox(height: 10),
                  TextInputForm(
                    // inputType: TextInputType.number,
                    enabled: true,
                    inputController: payController.bankNameController,
                    textHint: 'Select Bank',
                    validatorMessage: 'Please select bank',
                    isPassword: false,
                    autoCorrect: false,
                    suffixIcon: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0)),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (BuildContext context) {
                            return BankListModalSheet(
                              onBankSelected: (selectedBank) {
                                payController.onSetSelectedBankName(selectedBank);
                                payController.bankNameController.text =
                                    selectedBank;
                                Navigator.pop(context);
                              },
                              allBanks: payController.allBanks,
                              initialSelectedBank:
                                  payController.selectedBankName.value,
                            );
                          },
                        );
                      },
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    initialValue: payController.bankNameController.text,
                  ),
                  const SizedBox(height: 10),
            LabelText(textLabel: "Account Number"),
            const SizedBox(height: 10),
            TextInputForm(
              inputType: TextInputType.number,
              enabled: true,
              inputController: payController.accountNumberController,
              onChanged: (value) {
                if (value.trim().length == 10) {
                  payController.fetchUserDataByAccountNumber();
                }
              },
              // textLabel: '08134678957462',
              textHint: 'Account Number',
              isPassword: false,
              autoCorrect: false,
              validatorMessage: 'Please enter recipient number',
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Beneficiary Name"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: false,
              inputController: payController.fullNameController,
              // initialValue: payController.fullNameController.text,
              // textLabel: 'Receipient Name',
              textHint: 'Beneficiary Name',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Amount"),
            const SizedBox(height: 16),
            TextInputForm(
              inputType: TextInputType.number,
              enabled: true,
              inputController: payController.amountController,
              // textLabel: 'Amount',
              textHint: 'N1200',
              validatorMessage: 'Please enter an amount',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "PIN"),
            const SizedBox(height: 16),
            TextInputForm(
                enabled: true,
                inputType: TextInputType.number,
                inputController: payController.pinController,
                // textLabel: 'Pin',
                textHint: '0000',
                validatorMessage: 'Enter your pin',
                isPassword: true,
                autoCorrect: false),
            const SizedBox(height: 25),
            StandardButton(
              text: 'Pay Now',
              onPressed: () {
                if (payController.formKey.currentState!.validate()) {
                  payController.payToBank();
                }
              },
            ),
          ],
        ));
  }
}
