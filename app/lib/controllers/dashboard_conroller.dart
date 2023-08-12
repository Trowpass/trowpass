// ignore_for_file: avoid_print

import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
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

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    fullName.value = session.readRiderFullName()!;
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }
}
