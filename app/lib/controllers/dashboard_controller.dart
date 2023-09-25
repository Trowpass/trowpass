// ignore_for_file: avoid_print, unnecessary_string_interpolations
import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/dashboard/dashboard.dart';
import 'package:app/services/requests/post_requests/re_create_wallet_request.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/pin/choose_pin_screen.dart';
import '../shareds/managers/get_session_manager.dart';
import '../widgets/app_dialog.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');
  final fullName = Rx<String>('');
  final accountNumber = Rx<String>('');
  final bankName = Rx<String>('');
  final phoneNumber = Rx<String>('');
  final balance = Rx<String>('');
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);
  RxDouble sliderValue = 0.0.obs;
  final double slideWidth = 200.0;

  void onSlideChanged(double value) {
    sliderValue.value = value;
  }

  GetSessionManager session = GetSessionManager();
  SetSessionManager session2 = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = true;
    fullName.value = session.readRiderFullName() ?? '';
    balance.value = formatCurrency(session.readUserAccountBalance() ?? 0.0);
    bankName.value = session.readUserBankName() ?? '';
    accountNumber.value = session.readUserAccountNumber() ?? '';
    phoneNumber.value = '';
    userProfile();
    userWallet();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  Future userProfile() async {
    var response = await userController.userProfileAsync();
    if (response.status) {
      var fullName2 =
          '${response.data!.firstName.toTitleCase()} ${response.data!.lastName.toCapitalized()}';
      session2.writeUserFullName(fullName2);
      session2.writePinCreated(response.data!.isPinCreated);
      fullName.value = fullName2;
      if (!response.data!.isPinCreated) {
        Get.to(() => ChoosePinScreen());
      }
    }
  }

  Future userWallet() async {
    var response = await userController.userWalletAsync();
    if (response.status) {
      accountNumber.value = response.data!.accountNumber;
      bankName.value = response.data!.bankName;
      phoneNumber.value = response.data!.phoneNumber;
      double balance1 = response.data!.balance;
      balance.value = formatCurrency(balance1);
      session2.writeUserAccountNumber(accountNumber.value);
      session2.writeUserAccountBalance(balance1);
      session2.writeUserBankName(bankName.value);
    }
  }

  Future<void> reCreateWallet() async {
    isLoaded.value = true;
    try {
      int userId = session.readUserId() ?? 0;
      var response = await userController
          .reCreateWalletAsync(ReCreateWalletRequest(userId: userId));
      if (response.status) {
        Get.offAll(() => DashboardScreen());
        isLoaded.value = false;
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

  Future<dynamic> displayPlaceholderDialog(String pageTitle) {
    return placeholderDialog(pageTitle);
  }
}
