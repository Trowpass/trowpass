import 'dart:async';

import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/widgets/app_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services/requests/post_requests/reset_password_request.dart';
import '../shareds/utils/app_colors.dart';
import '../widgets/password_strength_bar.dart';
import 'bloc/user_controller.dart';

class NewPasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final isLoaded = false.obs;
  var isFocused = false.obs;
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  final strength = Rx(Strength.weak);
  final password = ''.obs;
  final displayText = ''.obs;
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final userController = UserController();
  GetSessionManager session = GetSessionManager();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  Future<void> resetPassword(String otp, String email) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      String resetToken = session.readResetPasswordToken();
      var resetPasswordRequest = ResetPasswordRequest(
          otp: otp,
          newPassword: passwordController.text,
          email: email,
          resetToken: resetToken);
      var response =
          await userController.resetPasswordAsync(resetPasswordRequest);
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
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoaded.value = false;
    }
  }

  void checkPassword(String value) {
    password.value = value.trim();
    if (password.isEmpty) {
      strength.value = Strength.weak;
    } else if (password.value.length < 8) {
      strength.value = Strength.weak;
    } else {
      if (!regex.hasMatch(password.value)) {
        strength.value = Strength.moderate;
      } else {
        strength.value = Strength.secure;
      }
    }
  }

  void proceedReset(String otp, String email) {
    final isValidated = formKey.currentState!.validate();
    var isPasswordSecure = strength.value == Strength.secure;

    if (isValidated) {
      if (isPasswordSecure) {
        formKey.currentState!.save();
        resetPassword(otp, email);
      } else {
        var title = 'Password not secure';
        var subtitle =
            'Password should be at least 8 characters long and include a mix of'
            ' uppercase and lowercase letters, numbers,'
            ' and special characters (such as !, @, #, \$, etc.) for added security';

        showAppDialog(
          type: DialogType.warning,
          title: title,
          subtitle: subtitle,
        );
      }
    }
  }
}
