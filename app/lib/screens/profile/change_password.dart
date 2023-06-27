import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../../widgets/standard_button.dart';
import '../../../widgets/text_form_input.dart';
import '../../controllers/change_password_controller.dart';
import '../../widgets/app_logo.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());

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
                title: Text(
                  'Change Password',
                  style: appStyles(18, null, FontWeight.w300),
                ),
                centerTitle: true,
                backgroundColor: primaryColor,
              ),
              body: GestureDetector(
                onTap: () => Get.focusScope!.unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Obx(() => Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Current Password',
                                  style: appStyles(18, null, FontWeight.w300)),
                              subtitle: TextInputForm(
                                  enabled: true,
                                  inputController:
                                      controller.currentPasswordController,
                                  textHint: 'enter password',
                                  validatorMessage:
                                      'Please enter current password',
                                  isPassword:
                                      !controller.isCurrentPassword.value,
                                  autoCorrect: false,
                                  suffixIcon: IconButton(
                                    icon: controller.isCurrentPassword.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    color: controller.isFocused.value
                                        ? primaryColor
                                        : null,
                                    onPressed: () {
                                      controller.isCurrentPassword.value =
                                          !controller.isCurrentPassword.value;
                                    },
                                  )),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('New Password',
                                  style: appStyles(18, null, FontWeight.w300)),
                              subtitle: TextInputForm(
                                enabled: true,
                                inputController:
                                    controller.newPasswordController,
                                textHint: 'enter password',
                                validatorMessage: 'Please enter new password',
                                isPassword: !controller.isNewPassword.value,
                                autoCorrect: false,
                                suffixIcon: IconButton(
                                  icon: controller.isNewPassword.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  color: controller.isFocused.value
                                      ? primaryColor
                                      : null,
                                  onPressed: () {
                                    controller.isNewPassword.value =
                                        !controller.isNewPassword.value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Confirm New Password',
                                  style: appStyles(18, null, FontWeight.w300)),
                              subtitle: TextInputForm(
                                  enabled: true,
                                  inputController:
                                      controller.confirmNewPasswordController,
                                  textHint: 'enter password',
                                  validatorMessage:
                                      'Please retype new password',
                                  isPassword:
                                      !controller.isConfirmPassword.value,
                                  autoCorrect: false,
                                  suffixIcon: IconButton(
                                    icon: controller.isConfirmPassword.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    color: controller.isFocused.value
                                        ? primaryColor
                                        : null,
                                    onPressed: () {
                                      controller.isConfirmPassword.value =
                                          !controller.isConfirmPassword.value;
                                    },
                                  )),
                            ),
                            const SizedBox(height: 10),
                            StandardButton(
                              text: 'Change Password',
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.changePassword();
                                }
                              },
                            ),
                          ],
                        ))),
                  ),
                ),
              ),
            ))));
  }
}
