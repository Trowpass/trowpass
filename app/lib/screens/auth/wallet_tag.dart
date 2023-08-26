// ignore_for_file: prefer_const_constructors

import 'package:app/controllers/wallet_tag_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../widgets/app_logo.dart';

class WalletTagScreen extends StatelessWidget {
  WalletTagScreen({super.key});
  final controller = Get.put(WalletTagController());

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
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Create Wallet Tag!',
                              style: appStyles(24, null, FontWeight.w600),
                            ),
                            // const SizedBox(height: 22),
                            // Text(
                            //   'Log in to your account.',
                            //   style: appStyles(
                            //     16,
                            //     Colors.black,
                            //     FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                               TextInputForm(
                                    enabled: true,
                                    inputController:
                                        controller.walletTagController,
                                    textLabel: 'Enter a name',
                                    textHint: 'Enter a name',
                                    validatorMessage:
                                        'Please enter a valid name',
                                    isPassword: false,
                                    autoCorrect: false,
                                    prefixIcon: const Icon(
                                      Icons.person_outline_outlined,
                                      size: 30,
                                    ),
                                  ),
                              const SizedBox(height: 16),
                              StandardButton(
                                text: 'Create',
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.formKey.currentState!.save();
                                    controller.walletTag();
                                  } else {}
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
