// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:app/widgets/all_banks_list.dart';
import 'package:app/widgets/all_transport_company_list.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:get/get.dart';

import '../../controllers/top_up_transport_wallet_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/text_form_input.dart';

class TopUpTransportWalletScreen extends StatelessWidget {
  TopUpTransportWalletScreen({super.key});

  final controller = Get.put(TopUpTransportWalletController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    controller.clearTextFields();
    return Obx(() => OverlayIndeterminateProgress(
        isLoading: controller.isLoaded.value,
        overlayBackgroundColor: background,
        progressColor: primaryColor,
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
              title: Text(controller.title.value,
                  style: appStyles(20, titleActive, FontWeight.w500)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: background,
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
              )),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      controller.subTitle.value,
                      style: appStyles(16, null, FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "Transport Company"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    inputType: TextInputType.number,
                    enabled: true,
                    inputController:
                        controller.transportCompanyNameTextEditController,
                    textHint: 'Select Transport Company',
                    validatorMessage: 'Please transport company',
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
                            return TransportCompanyListModalSheet(
                              onTransportCompanySelected: (selectedCompany) {
                                controller.onSetSelectedTransportCompany(
                                    selectedCompany);
                                controller
                                    .transportCompanyNameTextEditController
                                    .text = selectedCompany;
                                Navigator.pop(context);
                              },
                              allTransportCompany:
                                  controller.allTransportCompany,
                              initialSelectedTransportCompany:
                                  controller.selectedTransportCompany.value,
                            );
                          },
                        );
                      },
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    initialValue:
                        controller.transportCompanyNameTextEditController.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "Bank Name"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    enabled: true,
                    inputController: controller.bankNameTextEditController,
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
                                controller.onSetSelectedBankName(selectedBank);
                                controller.bankNameTextEditController.text =
                                    selectedBank;
                                Navigator.pop(context);
                              },
                              allBanks: controller.allBanks,
                              initialSelectedBank:
                                  controller.selectedBankName.value,
                            );
                          },
                        );
                      },
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    initialValue: controller.bankNameTextEditController.text,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "Account/Wallet Number"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    inputType: TextInputType.number,
                    enabled: true,
                    inputController:
                        controller.accountWalletNumberTextEditController,
                    onChanged: (value) {
                      if (value.trim().length == 10) {
                        controller.fetchUserDataByAccountNumber();
                      }
                    },
                    textHint: 'Account/Wallet Number',
                    validatorMessage: 'Please enter account number',
                    isPassword: false,
                    autoCorrect: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "Account Name"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    inputType: TextInputType.text,
                    enabled: false,
                    inputController: controller.accountNameTextEditController,
                    textHint: 'Account Name',
                    validatorMessage: 'Please enter account name',
                    isPassword: false,
                    autoCorrect: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "Amount"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    inputType: TextInputType.number,
                    enabled: true,
                    inputController: controller.amountTextEditController,
                    textHint: '0.00',
                    validatorMessage: 'Please enter an amount',
                    isPassword: false,
                    autoCorrect: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LabelText(textLabel: "PIN"),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputForm(
                    inputType: TextInputType.number,
                    enabled: true,
                    inputController: controller.pinTextEditController,
                    textHint: '0000',
                    validatorMessage: 'Enter your pin',
                    isPassword: false,
                    autoCorrect: false,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 5),
                      child: StandardButton(
                        text: 'Top-Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.topupTransportCompany();
                          }
                        },
                      ))
                ],
              ),
            ),
          )),
        )));
  }
}
