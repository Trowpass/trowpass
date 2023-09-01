import 'package:app/screens/auth/login.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart'
    as expiry_timer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart' as resend_timer;

import '../repositories/user_repository.dart';
import '../services/requests/post_requests/resend_otp_request.dart';
import '../services/requests/post_requests/verify_otp_request.dart';
import '../shareds/managers/get_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class OtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final title = Rx<String>('Account Verification');
  TextEditingController codeOneController = TextEditingController();
  TextEditingController codeTwoController = TextEditingController();
  TextEditingController codeThreeController = TextEditingController();
  TextEditingController codeFourController = TextEditingController();

  final isLoaded = false.obs;
  final isExpiryTimeElapsed = false.obs;
  final countdown = const Duration(minutes: 1).inSeconds;
  final countDownControllerDuration = const Duration(minutes: 5).inSeconds;
  final resendCountDownController = resend_timer.CountdownController();
  final expiryCountDownController = expiry_timer.CountDownController();

  final userRepository = UserRepository();
  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  void timerElapsed() {
    isExpiryTimeElapsed.value = true;
  }

  Future<void> verifyOtp() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      String otpValue =
          '${codeOneController.text}${codeTwoController.text}${codeThreeController.text}${codeFourController.text}';
      var response = await userController
          .verifyOtpAsync(VerifyOtpRequest(otp: otpValue.trim()));
      if (response.status) {
        Get.offAll(() => LoginScreen());
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

  Future<void> tryResendOtpSubmit(String phoneNumber) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();

    try {
      ResendOtpRequest request = ResendOtpRequest(phoneNumber: phoneNumber);
      var response = await userRepository.resendOtpToPhoneNumberAsync(request);

      if (response.status) {
        isLoaded.value = false;
        isExpiryTimeElapsed.value = false;
        resendCountDownController.restart();
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
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoaded.value = false;
    }
  }
}
