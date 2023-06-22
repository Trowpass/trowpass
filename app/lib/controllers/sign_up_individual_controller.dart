import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpIndividualController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
  }
}
