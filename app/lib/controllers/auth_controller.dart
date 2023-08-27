// ignore_for_file: avoid_print
import 'package:app/screens/auth/account_type_screen.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/navigation_menus/home_landing_tab_screen.dart';
import '../shareds/managers/set_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isPassword = false.obs;
  final showPassword = false.obs;
  final isFocused = false.obs;
  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  Future<void> login() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await userController.loginAsync(UserLoginRequest(
          phoneNumber: emailPhoneNumberController.text.trim(),
          password: passwordController.text.trim()));
      if (response.status) {
        session.writeAuthorizationToken(response.data!.token);
        session.writeUserId(response.data!.userId);
        Get.to(HomeLandingTabScreen());
      } else {
        // Check for invalid credentials specifically
        if (response.responseCode == "11") {
          Get.defaultDialog(
              title: 'Login Failed', content: Text(response.message));
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  void createAccount() {
    Get.to(const AccountTypeScreen());
  }
}
