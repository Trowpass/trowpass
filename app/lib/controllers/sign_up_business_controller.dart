import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpBusinessController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  
  final password = ''.obs;
  final strength = RxDouble(0);
  final displayText = 'Please enter a password'.obs;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }
  final TextEditingController bvnController = TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
  }

  void checkPassword(String value) {
    password.value = value.trim();
    if (password.isEmpty) {
      strength.value = 0;
      displayText.value = 'Please enter your password';
    } else if (password.value.length < 8) {
      strength.value = 1 / 4;
      displayText.value = 'Your password is too short';
    } else {
      if (!regex.hasMatch(password.value)) {
        strength.value = 3 / 4;
        displayText.value = 'Password not strong enough';
      } else {
        strength.value = 1;
        displayText.value = 'Your password is great';
      }
    }
  }
}
