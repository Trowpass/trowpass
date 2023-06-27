import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../controllers/reset_password_controller.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final controller = Get.put(ResetPasswordController());

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
              backgroundColor: primaryColor,
              title: const Text('Reset Password'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.check_box_rounded,
                      color: successColor,
                    ),
                    title: Text(
                      'Please enter the code sent to your phone number.',
                      style: appStyles(16, null, null),
                      textScaleFactor: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Form(
                        key: controller.formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeOneController,
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeTwoController,
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeThreeController,
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeFourController,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                    controller.showPasswordText.value = true;
                                  } else {
                                    controller.showPasswordText.value = false;
                                    controller.passwordController.clear();
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  controller.showPasswordText.isTrue
                      ? TextInputForm(
                          enabled: true,
                          inputController: controller.passwordController,
                          textLabel: 'New password',
                          textHint: 'New password',
                          validatorMessage: 'Please enter new password',
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
                          onTap: () => controller.isFocused.value = true,
                          onChanged: (_) => controller.isFocused.value = false,
                          onFieldSubmitted: (_) =>
                              controller.isFocused.value = false,
                        )
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  StandardButton(
                    text: 'Reset',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.resetPassword();
                      } else {}
                    },
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
