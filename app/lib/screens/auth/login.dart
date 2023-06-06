import 'package:app/controllers/auth_controller.dart';
import 'package:app/screens/auth/account_type_screen.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation_menus/home_landing_tab_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(loginImg),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Welcome back!',
                        style: appStyles(24, null, FontWeight.w600),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Log in to your account.',
                        style: appStyles(
                          16,
                          Colors.black,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                LoginForm(),
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
                    Get.to(() => const AccountTypeScreen());
                  },
                  child: Text(
                    'Sign Up',
                    style: appStyles(
                      14,
                      primaryColor,
                      FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const HomeLandingTabScreen());
                  },
                  child: Text(
                    'Go to bottom menu',
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
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final authController = Get.put(AuthController());

  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
        key: authController.formKey,
        child: Column(
          children: [
            Obx(() => TextInputForm(
                  inputController: authController.emailPhoneNumberController,
                  textLabel: 'Email or phone number',
                  textHint: 'Email or phone number',
                  validatorMessage:
                      'Please enter a valid email or phone number',
                  isPassword: false,
                  autoCorrect: false,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 30,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel,
                        color: authController.isFocused.value
                            ? primaryColor
                            : null),
                    onPressed: () {
                      authController.emailPhoneNumberController.clear();
                    },
                  ),
                )),
            const SizedBox(height: 16),
            Obx(() => TextInputForm(
                  inputController: authController.passwordController,
                  textLabel: 'Password',
                  textHint: 'Password',
                  validatorMessage: 'Please enter a valid password',
                  isPassword: !authController.isPassword.value,
                  autoCorrect: false,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 30,
                  ),
                  suffixIcon: IconButton(
                    icon: authController.isPassword.value
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: authController.isFocused.value ? primaryColor : null,
                    onPressed: () {
                      authController.isPassword.value =
                          !authController.isPassword.value;
                    },
                  ),
                  onTap: () => authController.isFocused.value = true,
                  onChanged: (_) => authController.isFocused.value = false,
                  onFieldSubmitted: (_) =>
                      authController.isFocused.value = false,
                )),
            const SizedBox(height: 25),
            StandardButton(
              text: 'LOG IN',
              onPressed: () {
                // login call
                if (authController.formKey.currentState!.validate()) {
                  authController.trySubmit();
                } else {}
              },
            ),
          ],
        ));
  }
}
