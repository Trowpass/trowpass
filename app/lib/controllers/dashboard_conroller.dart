// ignore_for_file: avoid_print, unnecessary_string_interpolations
import 'package:app/controllers/bloc/user_controller.dart';
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
  final balance = Rx<double>(0.0);
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    fullName.value = '';
    balance.value = 0.0;
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
      var response = await userController.userWalletAsync();
      if (response.status) {
        accountNumber.value = response.data!.accountNumber;
        balance.value = response.data!.balance;
        String originalName = response.data!.name;
        List<String> nameParts = originalName.split('-');
        String truncatedName = nameParts[0].trim();
        fullName.value = truncatedName;
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
