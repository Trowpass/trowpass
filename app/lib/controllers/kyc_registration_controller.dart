import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  TextEditingController bvnController = TextEditingController();

  Future<void> submitKyc() async {
    Get.focusScope!.unfocus();
    try {} catch (e) {}
  }
}
