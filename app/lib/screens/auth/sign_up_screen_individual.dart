import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sign_up_individual_controller.dart';

class SignUpScreenIndividual extends StatelessWidget {
  const SignUpScreenIndividual({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
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
                  style: appStyles(16, Colors.black, FontWeight.w400),
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
                    Get.to(() => const LoginScreen());
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
  final individualController = Get.put(SignUpIndividualController());
  SigUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: individualController.formKey,
        child: Column(
          children: [
            TextInputForm(
              enabled: true,
              inputController: individualController.fullNameController,
              textLabel: 'Full Name',
              textHint: 'Full Name',
              validatorMessage: 'Please enter a valid name',
              isPassword: false,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.person_outline_outlined,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: individualController.phoneNumberController,
              textLabel: 'Phone Number',
              textHint: 'Phone Number',
              validatorMessage: 'Please enter a valid number',
              isPassword: false,
              autoCorrect: false,
              prefixIcon: const Icon(
                Icons.phone_android,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: individualController.passwordController,
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
              inputController: individualController.confirmPasswordController,
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
                if (individualController.formKey.currentState!.validate()) {
                  individualController.trySubmit();
                }
              },
            ),
          ],
        ));
  }
}
