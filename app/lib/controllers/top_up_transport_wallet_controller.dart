import 'package:app/screens/wallet/top_up_transport_wallet_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpTransportWalletController extends GetxController {
  final title = Rx<String>('Topup your transport wallet');
  final subTitle = Rx<String>(
      'Easily fund your tansport wallet without opening several apps to do so.');
  final accountName = Rx<String>('Trowpass');

  final bankNameTextEditController = TextEditingController();
  final accountWalletNumberTextEditController = TextEditingController();
  final accountNameTextEditController = TextEditingController();
  final amountTextEditController = TextEditingController();
  final pinTextEditController = TextEditingController();

  List<dynamic> transportCompanies = [
    'Select company',
    'Cowry',
    'Shutter',
    'GIG',
    'Landstar Express',
    'GUO'
  ];

  List<dynamic> bankNames = ['Select bank', 'GTB', 'First Bank'];

  final selectedTransportCompany = 'Select company'.obs;
  final selectedBankName = 'Select bank'.obs;

  void onSetSelectedTransportCompany(Object? value) {
    selectedTransportCompany.value = value.toString();
  }

  void onSetSelectedBankName(Object? value) {
    selectedBankName.value = value.toString();
  }

  void trySubmit() {
    Get.focusScope!.unfocus();
    if (pinTextEditController.text.length <= 4) {
      Get.snackbar('Pin validation', 'Incomplete pin length');
    } else {
      Get.offAll(() => TopUpTransportWalletSummaryScreen());
    }
  }

  @override
  void onInit() {
    accountNameTextEditController.text = accountName.value;
    super.onInit();
  }
}
