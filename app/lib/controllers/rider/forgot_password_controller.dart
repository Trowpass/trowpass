import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/auth/forgot_password/forgot_password_otp_screen.dart';
import '../../services/requests/post_requests/forget_password_request.dart';
import '../../shareds/helpers/api_connection_helper.dart';
import '../../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class ForgotPassWordController extends GetxController {
  TextEditingController emailAddressInputController = TextEditingController();
  var apiConnectionHelper = ApiConnectionHelper();
  final formKey = GlobalKey<FormState>();
  final isFocused = false.obs;
  final isLoaded = false.obs;

  final userController = UserController();
  SetSessionManager session = SetSessionManager();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  void requestForgotPassword() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();

    try {
      var forgetPasswordRequest =
          ForgetPasswordRequest(email: emailAddressInputController.text);
      var response = await userController
          .requestForgotPasswordAsync(forgetPasswordRequest);
      if (response.status) {
        session.writeResetPasswordToken(response.data!.resetToken!);
        isLoaded.value = false;
        Get.offAll(() =>
            ForgotPasswordOtpScreen(email: emailAddressInputController.text));
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoaded.value = false;
    }
  }

  void tryResendOtpSubmit() {
    Get.snackbar(
      'Information',
      'No implemented yet',
      backgroundColor: dialogInfoBackground,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  bool isEmailValid(String? email) {
    if (email == null) {
      return false;
    } else {
      return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }
  }
}
