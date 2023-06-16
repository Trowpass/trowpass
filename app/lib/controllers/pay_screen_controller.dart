import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
    final TextEditingController pinController = TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
  }
}
