// ignore_for_file: prefer_const_constructors

import 'package:app/controllers/auth_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../widgets/app_logo.dart';
import 'forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWithAppIcon(
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
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Image.asset(loginImg),
                      const SizedBox(height: 32),
                      Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Obx(() => TextInputForm(
                                    inputType: TextInputType.number,
                                    enabled: true,
                                    inputController:
                                        controller.emailPhoneNumberController,
                                    textLabel: 'Enter phone number',
                                    textHint: 'Enter phone number',
                                    validatorMessage:
                                        'Please enter a valid phone number',
                                    isPassword: false,
                                    autoCorrect: false,
                                    prefixIcon: const Icon(
                                      Icons.phone_android_outlined,
                                      size: 30,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.cancel,
                                          color: controller.isFocused.value
                                              ? primaryColor
                                              : null),
                                      onPressed: () {
                                        controller.emailPhoneNumberController
                                            .clear();
                                      },
                                    ),
                                  )),
                              const SizedBox(height: 16),
                              Obx(() => TextInputForm(
                                    enabled: true,
                                    inputController:
                                        controller.passwordController,
                                    textLabel: 'Password',
                                    textHint: 'Password',
                                    validatorMessage:
                                        'Please enter a valid password',
                                    isPassword: !controller.isPassword.value,
                                    autoCorrect: false,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      size: 30,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: controller.isPassword.value
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                      color: controller.isFocused.value
                                          ? primaryColor
                                          : null,
                                      onPressed: () {
                                        controller.isPassword.value =
                                            !controller.isPassword.value;
                                      },
                                    ),
                                    onTap: () =>
                                        controller.isFocused.value = true,
                                    onChanged: (_) =>
                                        controller.isFocused.value = false,
                                    onFieldSubmitted: (_) =>
                                        controller.isFocused.value = false,
                                  )),
                              const SizedBox(height: 03),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () =>
                                      Get.to(() => ForgotPasswordScreen()),
                                  child: Text(
                                    'Forgot Password?',
                                    style: appStyles(
                                      14,
                                      grayscale,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              StandardButton(
                                text: 'LOG IN',
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.formKey.currentState!.save();
                                    controller.login();
                                  } else {}
                                },
                              ),
                            ],
                          )),
                      const SizedBox(height: 32),
                      Text(
                        'Don\'t have an account?',
                        style: appStyles(
                          14,
                          grayscale,
                          FontWeight.w600,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            controller.createAccount();
                          },
                          child: Text(
                            'Sign Up',
                          ))
                    ]),
                  ),
                )))));
  }
}
