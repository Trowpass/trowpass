import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/kyc_registration_controller.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class KycRegistrationScreen extends StatelessWidget {
  KycRegistrationScreen({super.key});
  final controller = Get.put(KycRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('KYC Registration'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope!.unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Date of Birth',
                  style: appStyles(18, null, FontWeight.w300)),
              subtitle: TextInputForm(
                inputController: controller.dobController,
                autoCorrect: false,
                enabled: true,
                isPassword: false,
                textHint: 'Select',
                validatorMessage: 'Please enter date of birth',
                prefixIcon: const Icon(Icons.calendar_month_outlined),
                suffixIcon: IconButton(
                    onPressed: () => controller.dobController.clear(),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    )),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    controller.dobController.text = formattedDate;
                    Get.focusScope!.unfocus();
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Bank Verification Number',
                  style: appStyles(18, null, FontWeight.w300)),
              subtitle: TextInputForm(
                inputType: TextInputType.number,
                enabled: true,
                inputController: controller.bvnController,
                textHint: 'bvn',
                validatorMessage: 'Please enter bvn',
                isPassword: false,
                autoCorrect: false,
                prefixIcon: const Icon(Icons.memory_rounded),
                suffixIcon: IconButton(
                    onPressed: () => controller.bvnController.clear(),
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    )),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            const SizedBox(height: 20),
            StandardButton(
              text: 'Update',
              onPressed: () async {
                if (controller.formKey.currentState!.validate()) {
                  controller.formKey.currentState!.save();
                  controller.submitKyc();
                }
              },
            ),
          ]),
        )),
      ),
    );
  }
}
