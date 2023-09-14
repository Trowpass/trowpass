import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/change_pin_controller.dart';
import '../../../widgets/standard_button.dart';
import '../../../widgets/text_form_input.dart';

class ChangePinScreen extends StatelessWidget {
  ChangePinScreen({super.key});
  final controller = Get.put(ChangePinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        elevation: 0.0,
        title: Text(
          'Change PIN',
          style: appStyles(18, titleActive, FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope!.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Enter Old PIN', style: appStyles(18, null, FontWeight.w500)),
                      subtitle: TextInputForm(
                        inputType: TextInputType.number,
                        enabled: true,
                        inputController: controller.oldPinController,
                        textHint: 'type PIN',
                        validatorMessage: 'Please enter old PIN',
                        isPassword: false,
                        autoCorrect: false,
                        suffixIcon: IconButton(
                            onPressed: () => controller.oldPinController.clear(),
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            )),
                        inputFormatters: [LengthLimitingTextInputFormatter(4), FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Enter New PIN', style: appStyles(18, null, FontWeight.w500)),
                      subtitle: TextInputForm(
                        inputType: TextInputType.number,
                        enabled: true,
                        inputController: controller.newPinController,
                        textHint: 'type PIN',
                        validatorMessage: 'Please enter new PIN',
                        isPassword: false,
                        autoCorrect: false,
                        suffixIcon: IconButton(
                            onPressed: () => controller.newPinController.clear(),
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            )),
                        inputFormatters: [LengthLimitingTextInputFormatter(4), FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Confirm New PIN', style: appStyles(18, null, FontWeight.w500)),
                      subtitle: TextInputForm(
                        inputType: TextInputType.number,
                        enabled: true,
                        inputController: controller.confirmNewPinController,
                        textHint: 'type PIN',
                        validatorMessage: 'Please retype new PIN',
                        isPassword: false,
                        autoCorrect: false,
                        suffixIcon: IconButton(
                            onPressed: () => controller.confirmNewPinController.clear(),
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            )),
                        inputFormatters: [LengthLimitingTextInputFormatter(4), FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const SizedBox(height: 10),
                    StandardButton(
                      text: 'Continue',
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          controller.changePin();
                        }
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
