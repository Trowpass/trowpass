import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../controllers/sign_up_individual_controller.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class SignUpScreenIndividual extends StatelessWidget {
  SignUpScreenIndividual({super.key});
  final controller = Get.put(SignUpIndividualController());

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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, right: 20, left: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'Let\'s Get Started!',
                      style: appStyles(24, null, FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Create an account with Trowpass',
                      style: appStyles(16, Colors.black, FontWeight.w400),
                    ),
                    const SizedBox(height: 32),
                    Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextInputForm(
                              enabled: true,
                              inputController: controller.firstNameController,
                              textLabel: 'First Name',
                              textHint: 'First Name',
                              validatorMessage: 'Please enter first name',
                              isPassword: false,
                              autoCorrect: false,
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextInputForm(
                              enabled: true,
                              inputController: controller.lastNameController,
                              textLabel: 'Last Name',
                              textHint: 'Last Name',
                              validatorMessage: 'Please enter last name',
                              isPassword: false,
                              autoCorrect: false,
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextInputForm(
                              inputType: TextInputType.emailAddress,
                              enabled: true,
                              inputController: controller.emailController,
                              textLabel: 'Email',
                              textHint: 'Email',
                              validatorMessage: 'Please enter your email',
                              isPassword: false,
                              autoCorrect: false,
                              prefixIcon: const Icon(
                                Icons.email,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextInputForm(
                              inputType: TextInputType.phone,
                              enabled: true,
                              inputController: controller.phoneNumberController,
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
                            const SizedBox(height: 10),
                            TextInputForm(
                              inputType: TextInputType.phone,
                              enabled: true,
                              inputController: controller.bvnController,
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
                            const SizedBox(height: 10),
                            TextInputForm(
                              enabled: true,
                              inputController: controller.passwordController,
                              textLabel: 'Password',
                              textHint: 'Password',
                              validatorMessage: 'Please enter a valid password',
                              isPassword: true,
                              autoCorrect: false,
                              prefixIcon: const Icon(
                                Icons.lock_clock_rounded,
                                size: 30,
                              ),
                              onChanged: (value) =>
                                  controller.checkPassword(value),
                            ),
                            SizedBox(
                              height: 17,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox.expand(
                                    child: LinearProgressIndicator(
                                        value: controller.strength.value,
                                        backgroundColor: Colors.red[500],
                                        color: controller.strength.value <=
                                                1 / 4
                                            ? Colors.red
                                            : controller.strength.value == 2 / 4
                                                ? Colors.yellow
                                                : controller.strength.value ==
                                                        3 / 4
                                                    ? Colors.blue
                                                    : Colors.green,
                                        minHeight: 15),
                                  ),
                                  Center(
                                      child:
                                          Text(controller.displayText.value)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextInputForm(
                              enabled: true,
                              inputController:
                                  controller.confirmPasswordController,
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
                            const SizedBox(height: 20),
                            StandardButton(
                              text: 'SIGN UP',
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.strength.value < 1 / 2
                                      ? null
                                      : controller.registerRider();
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
            ),
          ),
        )));
  }
}
