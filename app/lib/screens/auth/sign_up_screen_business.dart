import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/rider/sign_up_business_controller.dart';
import '../../widgets/overlay_indeterminate_progress.dart';
import '../../widgets/password_strength_bar.dart';

class SignUpScreenBusiness extends StatelessWidget {
  SignUpScreenBusiness({super.key});
  final businessController = Get.put(SignUpBusinessController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
        isLoading: businessController.isLoaded.value,
        overlayBackgroundColor: background,
        progressColor: primaryColor,
        child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: background,
                appBar: AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: primaryColor,
                    statusBarBrightness: Brightness.light, // For iOS
                    statusBarIconBrightness: Brightness.light, // For Android
                    systemNavigationBarColor: navigationBarBackground,
                    systemNavigationBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: background,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Let\'s Get Started!',
                          style: appStyles(24, null, FontWeight.w600),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Create an account with Trowpass',
                          style: appStyles(
                            16,
                            Colors.black,
                            FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Form(
                            key: businessController.formKey,
                            child: Column(
                              children: [
                                TextInputForm(
                                  enabled: true,
                                  inputController:
                                      businessController.businessNameController,
                                  textLabel: 'Business Name',
                                  textHint: 'Business Name',
                                  validatorMessage:
                                      'Please enter a valid business name',
                                  isPassword: false,
                                  autoCorrect: false,
                                  prefixIcon: const Icon(
                                    Icons.business_rounded,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextInputForm(
                                  enabled: true,
                                  inputController:
                                      businessController.emailController,
                                  textLabel: 'Company Email',
                                  textHint: 'Company Email',
                                  validatorMessage:
                                      'Please enter a valid email',
                                  isPassword: false,
                                  autoCorrect: false,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextInputForm(
                                  enabled: true,
                                  inputController:
                                      businessController.passwordController,
                                  textLabel: 'Password',
                                  textHint: 'Password',
                                  validatorMessage:
                                      'Please enter a valid password',
                                  isPassword:
                                      businessController.isPasswordHidden.value,
                                  autoCorrect: false,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 24,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      businessController.isPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: businessController.isFocused.value
                                          ? primaryColor
                                          : null,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      businessController
                                              .isPasswordHidden.value =
                                          !businessController
                                              .isPasswordHidden.value;
                                    },
                                  ),
                                  onChanged: (value) =>
                                      businessController.checkPassword(value),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Obx(() => PasswordStrengthBar(
                                      strength:
                                          businessController.strength.value)),
                                ),
                                TextInputForm(
                                  enabled: true,
                                  inputController: businessController
                                      .confirmPasswordController,
                                  textLabel: 'Confirm Password',
                                  textHint: 'Confirm password',
                                  validatorMessage: 'Passwords do not match',
                                  isPassword:
                                      businessController.isPasswordHidden.value,
                                  validator: (value) => businessController
                                              .passwordController.text !=
                                          value
                                      ? 'Password do not match'
                                      : null,
                                  autoCorrect: false,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 24,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      businessController.isPasswordHidden.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: businessController.isFocused.value
                                          ? primaryColor
                                          : null,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      businessController
                                              .isPasswordHidden.value =
                                          !businessController
                                              .isPasswordHidden.value;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 25),
                                StandardButton(
                                  text: 'SIGN UP',
                                  onPressed: () {
                                    if (businessController.formKey.currentState!
                                        .validate()) {
                                      businessController.strength.value !=
                                              Strength.secure
                                          ? null
                                          : businessController.trySubmit();
                                    }
                                  },
                                ),
                              ],
                            )),
                        const SizedBox(height: 32),
                        Text(
                          'Already have an account?',
                          style: appStyles(
                            14,
                            grayscale,
                            FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Text(
                            'Login here',
                            style: appStyles(
                              14,
                              primaryColor,
                              FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )))));
  }
}
