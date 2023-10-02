import 'package:app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/forgot_password/forgot_password_otp_screen.dart';
import '../services/requests/post_requests/forget_password_request.dart';
import '../shareds/helpers/api_connection_helper.dart';
import '../shareds/utils/app_colors.dart';

class ForgotPassWordController extends GetxController {
  TextEditingController emailAddressInputController = TextEditingController();
  var apiConnectionHelper = ApiConnectionHelper();
  final formKey = GlobalKey<FormState>();
  final isFocused = false.obs;
  final isLoaded = false.obs;

  UserRepository userRepository = UserRepository();

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
      var response = await userRepository
          .requestForgotPasswordAsync(forgetPasswordRequest);

      if (response.status) {
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
