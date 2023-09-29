import 'package:app/controllers/auth_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: primaryColor,
                  statusBarBrightness: Brightness.light, // For iOS
                  statusBarIconBrightness: Brightness.light, // For Android
                  systemNavigationBarColor: navigationBarBackground,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                backgroundColor: background,
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(loginImg),
                      const SizedBox(height: 32),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            Obx(() => TextInputForm(
                                  inputType: TextInputType.number,
                                  enabled: true,
                                  inputController: controller.emailPhoneNumberController,
                                  // textLabel: 'Enter phone number',
                                  textHint: 'Enter phone number',
                                  validatorMessage: 'Please enter a valid phone number',
                                  isPassword: false,
                                  autoCorrect: false,
                                  prefixIcon: Icon(
                                    Icons.phone_android_outlined,
                                    size: 24,
                                    color: controller.isFocused.value ? primaryColor : null,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.cancel, color: controller.isFocused.value ? primaryColor : null),
                                    onPressed: () {
                                      controller.emailPhoneNumberController.clear();
                                    },
                                  ),
                                )),
                            const SizedBox(height: 16),
                            Obx(() => TextInputForm(
                                  enabled: true,
                                  inputController: controller.passwordController,
                                  // textLabel: 'Password',
                                  textHint: 'Password',
                                  validatorMessage: 'Please enter a valid password',
                                  isPassword: !controller.isPassword.value,
                                  autoCorrect: false,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: controller.isFocused.value ? primaryColor : null,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: controller.isPassword.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    color: controller.isFocused.value ? primaryColor : null,
                                    onPressed: () {
                                      controller.isPassword.value = !controller.isPassword.value;
                                    },
                                  ),
                                  onFieldSubmitted: (_) => controller.isFocused.value = false,
                                )),
                            const SizedBox(height: 03),
                            Obx(() => CheckboxListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Remember me'),
                                  activeColor: primaryColor,
                                  value: controller.shouldRememberUser.value,
                                  onChanged: (newValue) {
                                    controller.shouldRememberUser.value = newValue ?? false;
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                )),
                            const SizedBox(height: 03),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () => Get.to(() => ForgotPasswordScreen()),
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
                                if (controller.formKey.currentState!.validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.login();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
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
                            style: appStyles(
                              14,
                              primaryColor,
                              FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
