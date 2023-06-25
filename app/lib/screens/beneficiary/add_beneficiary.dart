import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_beneficiary_controller.dart';
import '../../shareds/utils/border_radius.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_input.dart';

class AddBeneficiaryScreen extends StatelessWidget {
  AddBeneficiaryScreen({super.key});
  final controller = Get.put(AddBeneficiaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title.value),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
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
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius))),
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
                  ListTile(
                      contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                      title: const Text('Account/Wallet Number'),
                      subtitle: TextInput(
                        isReadOnly: false,
                        inputController:
                            controller.accountWalletNumberTextEditController,
                        textHint: 'Type here',
                        isPassword: false,
                        enabled: false,
                      )),
                  ListTile(
                      contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                      title: const Text('Account Name'),
                      subtitle: TextInput(
                        isReadOnly: true,
                        inputController:
                            controller.accountNameTextEditController,
                        isPassword: false,
                        enabled: false,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: StandardButton(
                        text: controller.title.value,
                        onPressed: () {
                          controller.trySubmit();
                        },
                      ))
                ],
              ))),
    );
  }
}
