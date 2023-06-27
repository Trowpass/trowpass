import 'package:app/screens/auth/reset_password.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final isFocused = false.obs;

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  Future<void> sendRestPasswordOtp() async {
    Get.focusScope!.unfocus();
    try {
      var response = await userController
          .resetPasswordOtpAsync(phoneNumberController.text.trim());
      if (response.status) {
        session.writeRiderPhoneNumber(phoneNumberController.text.trim());
        Get.to(ResetPasswordScreen());
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
