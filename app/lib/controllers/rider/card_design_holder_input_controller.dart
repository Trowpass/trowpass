import 'package:app/screens/rider/get_transport_card/card_request_successful.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDesignHolderInputController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();

  void trySubmit() {
   Get.to(() => CardRequestSucessfulScreen());
  }
}
