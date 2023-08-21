import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../../controllers/forgot_password_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/standard_button.dart';
import '../../../widgets/text_form_input.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordScreen extends StatelessWidget {
  final controller = Get.put(ForgotPassWordController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWithAppIcon(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          circularProgressColor: primaryColor,
          appIcon: appLogo(70, 70),
          child: Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFFE9E9E9),
                statusBarIconBrightness: Brightness.light, // For Android
                statusBarBrightness: Brightness.light, // For iOS
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
                style: appStyles(18, titleActive, FontWeight.w500),
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
                        style: appStyles(16, null, null),
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
                          onTap: () => controller.isFocused.value = true,
                          onChanged: (_) => controller.isFocused.value = false,
                          onFieldSubmitted: (_) => controller.isFocused.value = false,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 30,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: controller.isFocused.value ? primaryColor : null,
                              size: 30,
                            ),
                            onPressed: () => controller.emailAddressInputController.clear(),
                          ),
                        ),
                      );
                    }),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => controller.tryResendOtpSubmit(),
                                child: Text(
                                  'Resend',
                                  style: appStyles(16, grayscale, FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
