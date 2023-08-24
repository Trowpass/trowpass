// ignore_for_file: avoid_print

import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');
  final fullName = Rx<String>('');
  final accountNumber = Rx<String>('');
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    fullName.value = '';
    accountNumber.value = '';
    userProfile();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  Future userProfile() async {
    try {
      isLoaded.value = true;
      var response = await userController.userProfileAsync();
      if (response.status) {
        accountNumber.value = response.data.accountDetail.accountNumber;
        qrCodeUrl.value = response.data.privateQRCode;
        fullName.value = '${response.data.firstName.toTitleCase()} ${response.data.lastName.toCapitalized()}';
        session.writeUserFullName(fullName);

      } else {
        Get.defaultDialog(
            title: 'Information',
            content: const Text('Unable to fetch profile'));
        Get.to(LoginScreen());
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
}
