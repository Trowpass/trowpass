// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:app/controllers/bloc/pay_to_bank_controller.dart';
import 'package:app/controllers/dashboard_controller.dart';
import 'package:app/screens/send_money/pay_to_bank/receipt.dart';
import 'package:app/services/requests/post_requests/pay_to_bank_request.dart';
import 'package:app/services/requests/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/pay_to_bank_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayToBankController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final selectedBankName = 'Select bank'.obs;
  final isLoaded = false.obs;
  final PaytToBankController paytToBankController = PaytToBankController();

  @override
  void onInit() {
    isLoaded.value = false;
    fetchBankDetailsFromSessionStorage();
    accountNumberController.addListener(() {
      if (accountNumberController.text.trim().length == 10) {
        fetchUserDataByAccountNumber();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchBankDetailsFromSessionStorage();
    super.onReady();
  }

  void clearTextFields() {
    accountNumberController.clear();
    bankNameController.clear();
    fullNameController.clear();
    amountController.clear();
    pinController.clear();
  }

  GetSessionManager session = GetSessionManager();

  void onSetSelectedBankName(Object? value) {
    selectedBankName.value = value.toString();
  }

  List<String> allBanks = [];
  List<String> allBankNames = [];
  Map<String, int> bankIdMap = {};
  Map<String, String> bankCodeMap = {};

  void fetchBankDetailsFromSessionStorage() {
    try {
      // Retrieve bank details from session storage
      List<String> storedBanks = session.readAllBanks('allBanks');
      String storedSelectedBankName =
          session.readSelectedBankName('selectedBankName') ?? 'Select bank';
      Map<String, int> storedBankIdMap = session.readBankIdMap('bankIdMap');
      Map<String, String> storedBankCodeMap =
          session.readbankCodeMap('bankCodeMap');

      // Update controller's variables with retrieved values
      allBanks = storedBanks;
      selectedBankName.value = storedSelectedBankName;
      bankIdMap = storedBankIdMap;
      bankCodeMap = storedBankCodeMap;
    } catch (e) {
      print('Error fetching bank details from: $e');
    }
  }

  String getSelectedBankCode() {
    return bankCodeMap[selectedBankName.value] ?? "";
  }

  int getSelectedBankId() {
    return bankIdMap[selectedBankName.value] ?? 0;
  }

  void fetchUserDataByAccountNumber() async {
    if (accountNumberController.text.trim().length == 10) {
      isLoaded.value = true;
      try {
        String selectedBankCode = getSelectedBankCode();
        var accountNumber = accountNumberController.text.trim();
        var response = await paytToBankController.getUserByAccountNumberAsync(
            UserByAccountNumberRequest(
                accountNumber: accountNumber, bankCode: selectedBankCode));

        if (response.status) {
          String fullName = "${response.data!.accountName}";
          fullNameController.text = fullName;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      } catch (e) {
        Get.snackbar('Information', e.toString(),
            backgroundColor: dialogInfoBackground,
            snackPosition: SnackPosition.BOTTOM);
        isLoaded.value = false;
      }
    }
  }

  Future<void> payToBank() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      int bankId = getSelectedBankId();
      int senderUserId = session.readUserId() as int;
      var response = await paytToBankController.payToBankAsync(PayToBankRequest(
          senderUserId: senderUserId,
          beneficiaryAccountNumber: accountNumberController.text.trim(),
          beneficiaryName: fullNameController.text.trim(),
          amount: int.parse(amountController.text),
          bankId: bankId,
          pin: pinController.text.trim()));
      if (response.status) {
        PayToBankData transactionDetails = response.data!;
        PayToBankResponse parsedResponse = PayToBankResponse(
          status: response.status,
          message: response.message,
          responseCode: response.responseCode,
          data: transactionDetails,
        );
        Get.find<DashboardController>().userWallet();
        Get.offAll(() => PayToBankReceiptScreen(
              transactionDetails: parsedResponse,
            ));
      } else {
        if (response.responseCode == "11") {
          Get.defaultDialog(
              title: 'Failed',
              content: Text(
                response.message,
                style: TextStyle(color: Colors.white),
              ));
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
