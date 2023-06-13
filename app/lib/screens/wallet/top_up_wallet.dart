import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/top_up_wallet_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/border_radius.dart';

class TopUpWalletScreen extends StatelessWidget {
  TopUpWalletScreen({super.key});

  final controller = Get.put(TopUpWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title.value),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                controller.subTitle.value,
                style: appStyles(16, null, null),
              ),
            ),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('Transport Company'),
                subtitle: Obx(() => DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: grayscale),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: grayscale),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius))),
                      onChanged: (Object? newSeleted) {
                        controller.onSetSelectedTransportCompany(newSeleted);
                      },
                      isExpanded: true,
                      value: controller.selectedTransportCompany.value,
                      items: controller.transportCompanies.map((selectedType) {
                        return DropdownMenuItem(
                          value: selectedType,
                          child: Text(
                            selectedType,
                          ),
                        );
                      }).toList(),
                    ))),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('Bank Name'),
                subtitle: Obx(() => DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: grayscale),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius))),
                      onChanged: (Object? newSeleted) {
                        controller.onSetSelectedBankName(newSeleted);
                      },
                      isExpanded: true,
                      value: controller.selectedBankName.value,
                      items: controller.bankNames.map((selectedType) {
                        return DropdownMenuItem(
                          value: selectedType,
                          child: Text(
                            selectedType,
                          ),
                        );
                      }).toList(),
                    ))),
            GestureDetector(
              onTap: null,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Select Beneficiary',
                  style:
                      appStyleWithMoreProps(null, null, FontWeight.bold, null),
                ),
              ),
            ),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('Account/Wallet Number'),
                subtitle: TextInput(
                    isReadOnly: false,
                    inputController:
                        controller.accountWalletNumberTextEditController,
                    textHint: 'Type here',
                    isPassword: false)),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('Account Name'),
                subtitle: TextInput(
                    isReadOnly: true,
                    inputController: controller.accountNameTextEditController,
                    isPassword: false)),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('Amount'),
                subtitle: TextInput(
                    keyboardType: TextInputType.number,
                    isReadOnly: false,
                    inputController: controller.amountTextEditController,
                    textHint: '0.00',
                    isPassword: false)),
            ListTile(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                title: const Text('PIN'),
                subtitle: TextInput(
                    keyboardType: TextInputType.number,
                    isReadOnly: false,
                    inputController: controller.pinTextEditController,
                    textHint: 'Pin',
                    isPassword: true)),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: StandardButton(
                  text: 'Top-Up',
                  onPressed: () {
                    controller.trySubmit();
                  },
                ))
          ],
        ),
      )),
    );
  }
}
