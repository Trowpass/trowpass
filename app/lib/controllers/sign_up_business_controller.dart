import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpBusinessController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
  }
}
