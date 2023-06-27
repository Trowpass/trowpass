import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/screens/settings/settings.dart';
import 'package:app/services/requests/post_requests/change_password_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final isCurrentPassword = false.obs;
  final isNewPassword = false.obs;
  final isConfirmPassword = false.obs;
  final isFocused = false.obs;
  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  UserController userController = UserController();

  Future<void> changePassword() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      if (newPasswordController.text.trim() !=
          confirmNewPasswordController.text.trim()) {
        Get.defaultDialog(
            title: 'Information', content: const Text('Password mis-matched'));
      } else {
        var response = await userController.changePasswordAsync(
            ChangePasswordRequest(
                currentPassword: currentPasswordController.text.trim(),
                newPassword: newPasswordController.text.trim()));
        if (response.status) {
          Get.defaultDialog(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              title: 'Information',
              content: const Text('Password changed successfully.'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Get.to(const SettingScreen());
                      isLoaded.value = false;
                    },
                    icon: const Icon(
                      Icons.check_circle_rounded,
                      color: successColor,
                    ),
                    label: const Text('Ok'))
              ]);
          isLoaded.value = false;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
          isLoaded.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
