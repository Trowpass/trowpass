import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sign_up_business_controller.dart';

class SignUpScreenBusiness extends StatelessWidget {
  const SignUpScreenBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
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
                  'Create an account with SanwoPay',
                  style: appStyles(
                    16,
                    Colors.black,
                    FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                SigUpForm(),
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
        ),
      ),
    );
  }
}

class SigUpForm extends StatelessWidget {
  final businessController = Get.put(SignUpBusinessController());
  SigUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: businessController.formKey,
        child: Column(
          children: [
            TextInputForm(
              enabled: true,
              inputController: businessController.businessNameController,
              textLabel: 'Business Name',
              textHint: 'Business Name',
              validatorMessage: 'Please enter a valid business name',
              isPassword: false,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.business_rounded,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: businessController.emailController,
              textLabel: 'Company Email',
              textHint: 'Company Email',
              validatorMessage: 'Please enter a valid email',
              isPassword: false,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              inputType: TextInputType.phone,
              enabled: true,
              inputController: businessController.bvnController,
              textLabel: 'BVN',
              textHint: 'Enter your BVN',
              validatorMessage: 'Please enter a valid bvn',
              isPassword: false,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.confirmation_number_rounded,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: businessController.passwordController,
              textLabel: 'Password',
              textHint: 'Password',
              validatorMessage: 'Please enter a valid password',
              isPassword: true,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.lock,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: businessController.confirmPasswordController,
              textLabel: 'Confirm Password',
              textHint: 'Confirm password',
              validatorMessage: 'Passwords do not match',
              isPassword: true,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.lock,
                size: 30,
              ),
            ),
            const SizedBox(height: 25),
            StandardButton(
              text: 'SIGN UP',
              onPressed: () {
                if (businessController.formKey.currentState!.validate()) {
                  businessController.trySubmit();
                }
              },
            ),
          ],
        ));
  }
}
