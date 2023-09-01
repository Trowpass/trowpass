import 'dart:async';

import 'package:app/screens/auth/login.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../repositories/user_repository.dart';
import '../services/requests/post_requests/reset_password_request.dart';
import '../shareds/utils/app_colors.dart';

class NewPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final isLoaded = false.obs;
  var isFocused = false.obs;
  var is2Focused = false.obs;
  var isPassword1Hidden = true.obs;
  var isPassword2Hidden = true.obs;

  UserRepository userRepository = UserRepository();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  Future<void> resetPassword(String otp, String email) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();

    try {
      var resetPasswordRequest = ResetPasswordRequest(
          otp: otp, newPassword: passwordController.text, email: email);
      var response =
          await userRepository.resetPasswordAsync(resetPasswordRequest);

      if (response.status) {
        isLoaded.value = false;
        Get.defaultDialog(title: 'Success', content: Text(response.message));
        Timer(
          const Duration(milliseconds: 1500),
          () => Get.offAll(() => LoginScreen()),
        );
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoaded.value = false;
    }
  }
}
