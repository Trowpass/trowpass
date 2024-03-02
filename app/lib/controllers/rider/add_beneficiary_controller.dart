import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBeneficiaryController extends GetxController {
  final title = Rx<String>('Add Beneficiary');
  final accountNameTextEditController = TextEditingController();
  final accountWalletNumberTextEditController = TextEditingController();

  List<dynamic> bankNames = ['Select bank', 'GTB', 'First Bank'];
  final selectedBankName = 'Select bank'.obs;
  final accountName = Rx<String>('Kodex');

  void onSetSelectedBankName(Object? value) {
    selectedBankName.value = value.toString();
  }

  @override
  void onInit() {
    accountNameTextEditController.text = accountName.value;
    super.onInit();
  }

  void trySubmit() {
    Get.focusScope!.unfocus();
    //  Get.to(TopUpTransportWalletSummaryScreen());
  }
}
