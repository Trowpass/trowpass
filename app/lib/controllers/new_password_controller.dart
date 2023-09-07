import 'dart:async';

import 'package:app/screens/auth/login.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../repositories/user_repository.dart';
import '../services/requests/post_requests/reset_password_request.dart';
import '../shareds/utils/app_colors.dart';
import '../widgets/password_strength_bar.dart';

class NewPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final isLoaded = false.obs;
  var isFocused = false.obs;
  var isPasswordHidden = true.obs;
  final strength = Rx(Strength.weak);
  final password = ''.obs;
  final displayText = ''.obs;
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

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
      var resetPasswordRequest = ResetPasswordRequest(otp: otp, newPassword: passwordController.text, email: email);
      var response = await userRepository.resetPasswordAsync(resetPasswordRequest);

      if (response.status) {
        isLoaded.value = false;
        Get.defaultDialog(title: 'Success', content: Text(response.message));
        Timer(
          const Duration(milliseconds: 1500),
          () => Get.offAll(() => LoginScreen()),
        );
      } else {
        Get.defaultDialog(title: 'Information', content: Text(response.message));
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

  void checkPassword(String value) {
    password.value = value.trim();
    if (password.isEmpty) {
      strength.value = Strength.weak;
      displayText.value = 'Please enter your password';
    } else if (password.value.length < 8) {
      strength.value = Strength.weak;
      displayText.value = 'Your password is too short';
    } else {
      if (!regex.hasMatch(password.value)) {
        strength.value = Strength.moderate;
        displayText.value = 'Password not strong enough';
      } else {
        strength.value = Strength.secure;
        displayText.value = 'Your password is great';
      }
    }
  }
}
