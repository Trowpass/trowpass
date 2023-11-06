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
  final shouldRememberUser = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    shouldRememberUser.value = false;
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
            shouldRememberMe: shouldRememberUser.value),
      );
      if (response.status) {
        session.writeUserId(response.data!.userId);
        session.writeAuthorizationToken(response.data!.token);
        if (!response.data!.loginData!.isAccountVerified) {
          isLoaded.value = true;
          gotoVerification();
        } else if (!response.data!.loginData!.isPinCreated) {
          isLoaded.value = false;
          Get.to(() => ChoosePinScreen());
        } else {
          isLoaded.value = false;
          session.writeIsUserLoggedIn(true);
          session.writeTokenExpiration(response.data!.tokenExpires);
          session.writeShouldRememberMe(shouldRememberUser.value);
          Get.offAll(() => const HomeLandingTabScreen());
        }
      } else {
        // Check for invalid credentials specifically
        if (response.responseCode == "11") {
          isLoaded.value = false;
          Get.defaultDialog(
            title: 'Login Failed',
            content: Text(
              response.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else {
          isLoaded.value = false;
          Get.defaultDialog(
            title: 'Information',
            content: Text(
              response.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  void createAccount() {
    Get.to(const AccountTypeScreen());
  }

  Future gotoVerification() async {
    String phoneNumber = getSession.readRiderPhoneNumber() ?? '';
    Get.offAll(() => OtpScreen(phoneNumber: phoneNumber));
    //send new otp
    ResendOtpRequest request = ResendOtpRequest(phoneNumber: phoneNumber);
    var response = await userRepository.resendOtpToPhoneNumberAsync(request);
    if (response.status) {
      isLoaded.value = false;
      isExpiryTimeElapsed.value = false;
      resendCountDownController.restart();
      expiryCountDownController.restart();
    } else {
      Get.defaultDialog(
          title: 'Information',
          content: Text(response.message),
          backgroundColor: dialogInfoBackground);
      isLoaded.value = false;
    }
  }
}