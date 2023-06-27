import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/forgot_password_controller.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Forgot Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your registered phone number',
                    style: appStyles(16, null, null),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: TextInputForm(
                      inputType: TextInputType.phone,
                      enabled: true,
                      inputController: controller.phoneNumberController,
                      textLabel: 'Phone number',
                      textHint: 'Phone number',
                      validatorMessage: 'Please enter your phone number',
                      isPassword: false,
                      autoCorrect: false,
                      prefixIcon: const Icon(
                        Icons.phone_iphone_rounded,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel,
                            color: controller.isFocused.value
                                ? primaryColor
                                : null),
                        onPressed: () {
                          controller.phoneNumberController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardButton(
                    text: 'Reset Password',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.sendRestPasswordOtp();
                      }
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
