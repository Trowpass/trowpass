import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../controllers/sign_up_business_controller.dart';
import '../../widgets/app_logo.dart';

class SignUpScreenBusiness extends StatelessWidget {
  SignUpScreenBusiness({super.key});
  final businessController = Get.put(SignUpBusinessController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWithAppIcon(
        isLoading: businessController.isLoaded.value,
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
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextInputForm(
                              enabled: true,
                              inputController:
                                  businessController.emailController,
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
                              enabled: true,
                              inputController:
                                  businessController.passwordController,
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
                            SizedBox(
                              height: 15,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox.expand(
                                    child: LinearProgressIndicator(
                                        value:
                                            businessController.strength.value,
                                        backgroundColor: Colors.grey[300],
                                        color:
                                            businessController.strength.value <=
                                                    1 / 4
                                                ? Colors.red
                                                : businessController
                                                            .strength.value ==
                                                        2 / 4
                                                    ? Colors.yellow
                                                    : businessController
                                                                .strength
                                                                .value ==
                                                            3 / 4
                                                        ? Colors.blue
                                                        : Colors.green,
                                        minHeight: 15),
                                  ),
                                  Center(
                                      child: Text(businessController
                                          .displayText.value)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextInputForm(
                              enabled: true,
                              inputController:
                                  businessController.confirmPasswordController,
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
                                if (businessController.formKey.currentState!
                                    .validate()) {
                                  businessController.strength.value < 1 / 2
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
            ),
          ),
        )));
  }
}
