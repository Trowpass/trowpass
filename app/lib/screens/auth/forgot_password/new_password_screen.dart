import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../../controllers/new_password_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/standard_button.dart';
import '../../../widgets/text_form_input.dart';

class NewPasswordScreen extends StatelessWidget {
  final controller = Get.put(NewPasswordController());
  final String otp, email;

// ignore: use_key_in_widget_constructors
  NewPasswordScreen({required this.otp, required this.email});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => OverlayLoaderWithAppIcon(
        isLoading: controller.isLoaded.value,
        overlayBackgroundColor: background,
        circularProgressColor: primaryColor,
        appIcon: appLogo(70, 70),
        child: GestureDetector(
          onTap: () => Get.focusScope!.unfocus(),
          child: Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: background,
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: primaryColor,
                statusBarBrightness: Brightness.light, // For iOS
                statusBarIconBrightness: Brightness.light, // For Android
                systemNavigationBarColor: navigationBarBackground,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: appStyles(24, null, FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Choose new password to access your dashboard',
                        style: appStyles(16, null, null),
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: <Widget>[
                          Obx(() {
                            const validatorMessage = 'Password cannot be empty';
                            return TextInputForm(
                              enabled: true,
                              inputController: controller.passwordController,
                              textLabel: 'New Password',
                              textHint: 'New Password',
                              validatorMessage: validatorMessage,
                              isPassword: controller.isPassword1Hidden.value,
                              autoCorrect: false,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              validator: (value) => value != null && value.isEmpty ? validatorMessage : null,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPassword1Hidden.value ? Icons.visibility_off : Icons.visibility,
                                  color: controller.isFocused.value ? primaryColor : null,
                                  size: 30,
                                ),
                                onPressed: () => controller.isPassword1Hidden.value = !controller.isPassword1Hidden.value,
                              ),
                            );
                          }),
                          const SizedBox(height: 13),
                          Obx(() {
                            const validatorMessage = 'Password does not match';
                            return TextInputForm(
                              enabled: true,
                              inputController: controller.password2Controller,
                              textLabel: 'Confirm New Password',
                              textHint: 'Confirm New Password',
                              validatorMessage: validatorMessage,
                              validator: (value) => (value != controller.passwordController.text) ? validatorMessage : null,
                              isPassword: controller.isPassword2Hidden.value,
                              autoCorrect: false,
                              onTap: () => controller.is2Focused.value = true,
                              onChanged: (_) => controller.is2Focused.value = false,
                              onFieldSubmitted: (_) => controller.is2Focused.value = false,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPassword2Hidden.value ? Icons.visibility_off : Icons.visibility,
                                  color: controller.isFocused.value ? primaryColor : null,
                                  size: 30,
                                ),
                                onPressed: () => controller.isPassword2Hidden.value = !controller.isPassword2Hidden.value,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    StandardButton(
                      text: 'Change Password',
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          controller.resetPassword(otp, email);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
