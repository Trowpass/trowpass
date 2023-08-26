import 'package:app/screens/auth/login.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  final countDownController = CountDownController();
  final int countDownControllerDuration = 1900; // in seconds [5 minutes]
  final isTimeElapsed = false.obs;
  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  Future<void> verifyOtp() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      String otpValue =
          '${codeOneController.text}${codeTwoController.text}${codeThreeController.text}${codeFourController.text}';
      var response = await userController
          .verifyOtpAsync(VerifyOtpRequest(otp: otpValue.trim()));
      if (response.status) {
        Get.to(LoginScreen());
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

  void tryResendOtpSubmit() {
    Get.snackbar('Information', 'No implemented yet',
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM);
  }
}
