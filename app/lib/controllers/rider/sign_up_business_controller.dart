import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/password_strength_bar.dart';

class SignUpBusinessController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final password = ''.obs;
  final strength = Rx(Strength.weak);

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final isLoaded = false.obs;
  final isPasswordHidden = true.obs;
  final isFocused = false.obs;

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
      strength.value = Strength.weak;
    } else if (password.value.length < 8) {
      strength.value = Strength.weak;
    } else {
      if (!regex.hasMatch(password.value)) {
        strength.value = Strength.moderate;
      } else {
        strength.value = Strength.secure;
      }
    }
  }
}
