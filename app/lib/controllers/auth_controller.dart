// ignore_for_file: avoid_print, prefer_const_constructors
import 'package:app/repositories/user_repository.dart';
import 'package:app/screens/auth/account_type_screen.dart';
import 'package:app/screens/auth/otp.dart';
import 'package:app/screens/auth/pin/choose_pin_screen.dart';
import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/services/requests/post_requests/resend_otp_request.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart'
    as expiry_timer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart' as resend_timer;

import '../shareds/managers/set_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final resendCountDownController = resend_timer.CountdownController();
  final expiryCountDownController = expiry_timer.CountDownController();
  final isPassword = false.obs;
  final showPassword = false.obs;
  final isFocused = false.obs;
  final isLoaded = false.obs;
  final isExpiryTimeElapsed = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  void timerElapsed() {
    isExpiryTimeElapsed.value = true;
  }

  SetSessionManager session = SetSessionManager();
  GetSessionManager getSession = GetSessionManager();
  UserController userController = UserController();
  UserRepository userRepository = UserRepository();

  Future<void> login() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await userController.loginAsync(
        UserLoginRequest(
          phoneNumber: emailPhoneNumberController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      if (response.status) {
        session.writeAuthorizationToken(response.data!.token);
        session.writeUserId(response.data!.userId);
        session.writeIsUserLoggedIn(true);
        if (!response.data!.loginData!.isAccountVerified) {
          String phoneNumber = getSession.readRiderPhoneNumber() ?? '';
          //send new otp
          ResendOtpRequest request = ResendOtpRequest(phoneNumber: phoneNumber);
          var response =
              await userRepository.resendOtpToPhoneNumberAsync(request);
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
          Get.offAll(() => OtpScreen(phoneNumber: phoneNumber));
          isLoaded.value = false;
        } else if (!response.data!.loginData!.isPinCreated) {
          Get.to(() => ChoosePinScreen());
        } else {
          Get.offAll(() => HomeLandingTabScreen());
        }
      } else {
        // Check for invalid credentials specifically
        if (response.responseCode == "11") {
          Get.defaultDialog(
            title: 'Login Failed',
            content: Text(
              response.message,
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          Get.defaultDialog(
            title: 'Information',
            content: Text(
              response.message,
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        isLoaded.value = false;
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  void createAccount() {
    Get.to(const AccountTypeScreen());
  }
}
