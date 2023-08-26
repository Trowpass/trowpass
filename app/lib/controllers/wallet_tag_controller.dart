// ignore_for_file: avoid_print
import 'package:app/screens/dashboard/dashboard.dart';
import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/services/requests/post_requests/create_wallet_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class WalletTagController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController walletTagController =
      TextEditingController();

  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  Future<void> walletTag() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    
    try {
      int userId = session.readUserId() as int;
      var response = await userController.createWalletAsync(CreateWalletRequest(
          userId: userId,
          walletName: walletTagController.text.trim(),));
      if (response.status) {
      Get.to(HomeLandingTabScreen());
      } else {
        // Check for invalid credentials specifically
        if (response.responseCode == "11") {
          Get.defaultDialog(
              title: 'Failed', content: Text(response.message));
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
}
