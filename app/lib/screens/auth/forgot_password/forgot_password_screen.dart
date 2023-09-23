import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/forgot_password_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/overlay_indeterminate_progress.dart';
import '../../../widgets/standard_button.dart';
import '../../../widgets/text_form_input.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordScreen extends StatelessWidget {
  final controller = Get.put(ForgotPassWordController());

  @override
  Widget build(BuildContext context) {
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
              elevation: 0,
              title: Text(
                'Forgot Password',
                style: appStyles(20, titleActive, FontWeight.w500),
              ),
              backgroundColor: background,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        'Please enter your registered email and a confirmation OTP code will be sent to you.',
                        style: appStyles(16, null, FontWeight.w300),
                      ),
                    ),
                    Obx(() {
                      const validatorMessage = 'Please enter a valid email';
                      return Form(
                        key: controller.formKey,
                        child: TextInputForm(
                          enabled: true,
                          inputController: controller.emailAddressInputController,
                          textLabel: 'Email address',
                          textHint: 'Email Address',
                          validatorMessage: validatorMessage,
                          isPassword: false,
                          autoCorrect: false,
                          validator: (value) => controller.isEmailValid(value) ? null : validatorMessage,
                          onFieldSubmitted: (_) => controller.isFocused.value = false,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 24,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: controller.isFocused.value ? primaryColor : null,
                              size: 24,
                            ),
                            onPressed: () => controller.emailAddressInputController.clear(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    StandardButton(
                      text: 'Request OTP',
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.requestForgotPassword();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
