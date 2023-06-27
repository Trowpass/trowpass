import 'package:app/screens/auth/login.dart';
import 'package:app/services/requests/post_requests/reset_password_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController codeOneController = TextEditingController();
  final TextEditingController codeTwoController = TextEditingController();
  final TextEditingController codeThreeController = TextEditingController();
  final TextEditingController codeFourController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isFocused = false.obs;
  final isLoaded = false.obs;
  final isPassword = false.obs;
  final showPasswordText = false.obs;

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    showPasswordText.value = false;
    super.onInit();
  }

  Future<void> resetPassword() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      String otpValue =
          '${codeOneController.text}${codeTwoController.text}${codeThreeController.text}${codeFourController.text}';
      var response = await userController.resetPasswordAsync(
          ResetPasswordRequest(
              newPassword: passwordController.text.trim(),
              code: otpValue.trim()),
          session.readRiderPhoneNumber());
      if (response.status) {
        isLoaded.value = false;
        Get.defaultDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            title: 'Information',
            content: const Column(
              children: [
                Text('Your password has been reset successfully'),
                Divider()
              ],
            ),
            onConfirm: () => Get.to(LoginScreen()),
            onCancel: () => Get.to(LoginScreen()),
            textConfirm: 'Login now',
            confirmTextColor: primaryColor);
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
