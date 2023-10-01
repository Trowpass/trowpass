// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, prefer_const_constructors, avoid_print, unnecessary_string_interpolations, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison

import 'package:app/controllers/bloc/topup_transport_wallet_controller.dart';
import 'package:app/controllers/dashboard_controller.dart';
import 'package:app/screens/wallet/top_up_transport_wallet_done.dart';
import 'package:app/services/requests/post_requests/topup_transport_wallet_request.dart';
import 'package:app/services/requests/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/topup_transport_wallet_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpTransportWalletController extends GetxController {
  final title = Rx<String>('Topup your transport wallet');
  final subTitle = Rx<String>(
      'Easily fund your tansport wallet without opening several apps to do so.');
  final selectedTransportCompany = 'Select company'.obs;
  final selectedBankName = 'Select bank'.obs;
  final transportCompanyNameTextEditController = TextEditingController();
  final bankNameTextEditController = TextEditingController();
  final accountWalletNumberTextEditController = TextEditingController();
  final accountNameTextEditController = TextEditingController();
  final amountTextEditController = TextEditingController();
  final pinTextEditController = TextEditingController();

  final TopupTransportWalletController topupTransportWalletController =
      TopupTransportWalletController();
  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    fetchBankDetailsFromSessionStorage();
    fetchTransportCompanyDetailsFromSessionStorage();
    accountWalletNumberTextEditController.addListener(() {
      if (accountWalletNumberTextEditController.text.trim().length == 10) {
        fetchUserDataByAccountNumber();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchBankDetailsFromSessionStorage();
    fetchTransportCompanyDetailsFromSessionStorage();
    super.onReady();
  }

  void clearTextFields() {
    transportCompanyNameTextEditController.clear();
    bankNameTextEditController.clear();
    accountWalletNumberTextEditController.clear();
    accountNameTextEditController.clear();
    amountTextEditController.clear();
    pinTextEditController.clear();
  }

  GetSessionManager session = GetSessionManager();

  void onSetSelectedTransportCompany(Object? value) {
    selectedTransportCompany.value = value.toString();
  }

  void onSetSelectedBankName(Object? value) {
    selectedBankName.value = value.toString();
  }

  List<String> allBanks = [];
  List<String> allTransportCompany = [];
  List<String> allBankNames = [];
  Map<String, int> bankIdMap = {};
  Map<String, String> bankCodeMap = {};
  Map<String, int> transportCompanyIdMap = {};

  void fetchBankDetailsFromSessionStorage() {
    try {
      // Retrieve bank details from session storage
      List<String> storedBanks = session.readAllBanks('allBanks');
      String storedSelectedBankName = session.readSelectedBankName('selectedBankName') ?? 'Select bank';
      Map<String, int> storedBankIdMap = session.readBankIdMap('bankIdMap');
      Map<String, String> storedBankCodeMap = session.readbankCodeMap('bankCodeMap');

      // Update controller's variables with retrieved values
      allBanks = storedBanks;
      selectedBankName.value = storedSelectedBankName;
      bankIdMap = storedBankIdMap;
      bankCodeMap = storedBankCodeMap;
    } catch (e) {
      print('Error fetching bank details from: $e');
    }
  }

  void fetchTransportCompanyDetailsFromSessionStorage() {
    try {
      // Retrieve bank details from session storage
      List<String> storedTransportCompanies = session.readAllTransportCompanies('allTransportCompanies');
      String storedSelectedTransportCompanies = session.readSelectedTransportCompanies('selectedTransportCompany') ?? 'Select transport';
      Map<String, int> storedTransportIdMap = session.readTransportCompanyIdMap('transportCompanyIdMap');

      // Update controller's variables with retrieved values
      allTransportCompany = storedTransportCompanies;
      selectedTransportCompany.value = storedSelectedTransportCompanies;
      transportCompanyIdMap = storedTransportIdMap;
    } catch (e) {
      print('Error fetching transport company: $e');
    }
  }

  String getSelectedBankCode() {
    return bankCodeMap[selectedBankName.value] ?? "";
  }

  int getSelectedBankId() {
    return bankIdMap[selectedBankName.value] ?? 0;
  }

  int getSelectedTransportCompanyId() {
    return transportCompanyIdMap[selectedTransportCompany.value] ?? 0;
  }

  void fetchUserDataByAccountNumber() async {
    if (accountWalletNumberTextEditController.text.trim().length == 10) {
      isLoaded.value = true;
      try {
        String selectedBankCode = getSelectedBankCode();
        var accountNumber = accountWalletNumberTextEditController.text.trim();
        var response = await topupTransportWalletController
            .getUserByAccountNumberAsync(UserByAccountNumberRequest(
                accountNumber: accountNumber, bankCode: selectedBankCode));

        if (response.status) {
          String fullName = "${response.data!.accountName}";
          accountNameTextEditController.text = fullName;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      } catch (e) {
        Get.snackbar('Information', e.toString(),
            backgroundColor: validationErrorColor,
            snackPosition: SnackPosition.BOTTOM);
        isLoaded.value = false;
      }
    }
  }

  Future<void> topupTransportCompany() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      int bankId = getSelectedBankId();
      int transportCompanyID = getSelectedTransportCompanyId();
      int senderUserId = session.readUserId() as int;
      var response = await topupTransportWalletController
          .topupTransportWalletAsync(TopupTransportWalletRequest(
              senderUserId: senderUserId,
              recipientAccountNumber:
                  accountWalletNumberTextEditController.text.trim(),
              recipientAccountName: accountNameTextEditController.text.trim(),
              amount: int.parse(amountTextEditController.text),
              bankId: bankId,
              transportCompanyId: transportCompanyID,
              pin: pinTextEditController.text.trim()));
      if (response.status) {
        TopUpTransportWalletData transactionDetails = response.data!;
        TopUpTransportWalletResponse parsedResponse =
            TopUpTransportWalletResponse(
          status: response.status,
          message: response.message,
          responseCode: response.responseCode,
          data: transactionDetails,
        );
        Get.find<DashboardController>().userWallet();
        Get.offAll(() => TopUpTransportWalletDoneScreen(
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
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
