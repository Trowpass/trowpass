import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';

class ChangePinController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmNewPinController = TextEditingController();

  Future<void> changePin() async {
    Get.focusScope!.unfocus();
    try {
      if (newPinController.text.trim() != confirmNewPinController.text.trim()) {
        Get.defaultDialog(
            title: 'Information', content: const Text('PIN mis-matched'));
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
