import 'package:circular_countdown_timer/circular_countdown_timer.dart'
    as expiry_timer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart' as resend_timer;

import '../../screens/auth/pin/choose_pin_screen.dart';
import '../../services/requests/rider/post_requests/resend_otp_request.dart';
import '../../services/requests/rider/post_requests/verify_otp_request.dart';
import '../../shareds/managers/rider/get_session_manager.dart';
import '../../shareds/utils/app_colors.dart';
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
  final countDownControllerDuration = const Duration(minutes: 2).inSeconds;
  final resendCountDownController = resend_timer.CountdownController();
  final expiryCountDownController = expiry_timer.CountDownController();

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
        Get.offAll(() => ChoosePinScreen());
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message!));
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  Future<void> tryResendOtpSubmit(String phoneNumber) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await userController.resendOtpToPhoneNumberAsync(
          ResendOtpRequest(phoneNumber: phoneNumber));
      if (response.status) {
        isLoaded.value = false;
        isExpiryTimeElapsed.value = false;
        resendCountDownController.restart();
        expiryCountDownController.restart();
        Get.snackbar(
          'Information',
          response.message,
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoaded.value = false;
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

  Future<void> tryResendOtpToFleetManager(String email) async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await userController
          .resendOtpToFleetManagerAsync(ResendOtpRequest(email: email));
      if (response.status) {
        isLoaded.value = false;
        isExpiryTimeElapsed.value = false;
        resendCountDownController.restart();
        expiryCountDownController.restart();
        Get.snackbar(
          'Information',
          response.message,
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoaded.value = false;
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
}
