import 'package:app/repositories/user_repository.dart';
import 'package:app/screens/auth/forgot_password/new_password_screen.dart';
import 'package:app/services/requests/post_requests/resend_otp_request.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart'
    as expiry_timer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart' as resend_timer;

import '../shareds/utils/app_colors.dart';

class ForgotPasswordOtpController extends GetxController {
  TextEditingController codeFourController = TextEditingController();
  TextEditingController codeOneController = TextEditingController();
  TextEditingController codeThreeController = TextEditingController();
  TextEditingController codeTwoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isFocused = false.obs;
  final isLoaded = false.obs;
  var isExpiryTimeElapsed = false.obs;

  final resendCountdownDuration = const Duration(minutes: 1).inSeconds;
  final expiryCountDownDuration = const Duration(minutes: 5).inSeconds;
  final countDownController = resend_timer.CountdownController();
  final expiryCountDownController = expiry_timer.CountDownController();

  final UserRepository userRepository = UserRepository();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  void timerElapsed() {
    isExpiryTimeElapsed.value = true;
  }

  Future<void> tryResendOtpSubmit(String email) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();

    try {
      ResendOtpRequest request = ResendOtpRequest(email: email);
      var response = await userRepository.resendOtpToEmailAsync(request);

      if (response.status) {
        isExpiryTimeElapsed.value = false;
        isLoaded.value = false;
        countDownController.restart();
        expiryCountDownController.restart();
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

  void finishEnterOtp(String email) {
    var otpOne = codeOneController.text;
    var otpTwo = codeTwoController.text;
    var otpThree = codeThreeController.text;
    var otpFour = codeFourController.text;
    String otpValue = '$otpOne$otpTwo$otpThree$otpFour';
    Get.offAll(() => NewPasswordScreen(otp: otpValue, email: email));
  }
}
