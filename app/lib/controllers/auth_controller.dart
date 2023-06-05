import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneNumberController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isPassword = false.obs;
  final showPassword = false.obs;
  final isFocused = false.obs;

  void trySubmit() {
    Get.focusScope!.unfocus();
    // api call
  }
}
