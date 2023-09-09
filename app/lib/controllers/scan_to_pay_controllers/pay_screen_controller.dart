// PayController.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  final pinController = TextEditingController();
  final narrationController = TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
    // Implement your form submission logic here
  }
}
