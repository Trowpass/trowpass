// ignore_for_file: unused_local_variable

import 'package:app/controllers/rider/bloc/inter_wallet_transfer_controller.dart';
import 'package:app/controllers/rider/bloc/user_controller.dart';
import 'package:app/controllers/rider/dashboard_controller.dart';
import 'package:app/screens/rider/send_money/scan_to_pay/receipt.dart';
import 'package:app/services/requests/rider/post_requests/inter_wallet_transfer_request.dart';
import 'package:app/services/responses/rider/inter_wallet_transfer_response.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanQrPayController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final bankController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  final pinController = TextEditingController();
  final narrationController = TextEditingController();

  final TextEditingController expenseTypeController = TextEditingController();
  final selectedExpenseTypeName = 'Select expense type'.obs;

  List<String> allExpenseTypes = [];
  List<String> allExpenseTypeNames = [];
  Map<String, int> expenseTypeIdMap = {};

  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    fetchExpenseTypeDetailsFromSessionStorage();
    super.onReady();
  }

  void onSetSelectedExpenseTypeName(Object? value) {
    selectedExpenseTypeName.value = value.toString();
  }

  void clearTextFields() {
    phoneNumberController.clear();
    nameController.clear();
    amountController.clear();
    narrationController.clear();
    pinController.clear();
  }

  GetSessionManager session = GetSessionManager();
  InterwalletController interwalletController = InterwalletController();
  UserController userController = UserController();

  int getSelectedExpenseTypeId() {
    return expenseTypeIdMap[selectedExpenseTypeName.value] ?? 0;
  }

  void fetchExpenseTypeDetailsFromSessionStorage() {
    try {
      // Retrieve bank details from session storage
      List<String> storedExpenseTypes =
          session.readAllExpenseTypes('allExpenseTypes');
      String storedselectedExpenseTypeName =
          session.readSelectedExpenseTypeName('selectedExpenseTypeName') ??
              'Select expense type';
      Map<String, int> storedexpenseTypeIdMap =
          session.readExpenseTypeIdMap('expenseTypeIdMap');
      // Update controller's variables with retrieved values
      allExpenseTypes = storedExpenseTypes;
      selectedExpenseTypeName.value = storedselectedExpenseTypeName;
      expenseTypeIdMap = storedexpenseTypeIdMap;
    } catch (e) {
      print('Error fetching bank details from: $e');
    }
  }

  Future<void> scanToPay() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      int expenseTypeId = getSelectedExpenseTypeId();
      int senderUserId = session.readUserId() as int;
      var response = await interwalletController
          .interWalletTransferAsync(InterWalletTransferRequest(
        senderUserId: senderUserId,
        recipientPhoneNumber: phoneNumberController.text.trim(),
        narration: narrationController.text.trim(),
        amount: int.parse(amountController.text),
        transportExpenseId: expenseTypeId,
        pin: pinController.text.trim(),
      ));
      if (response.status) {
        TransferResponseData transactionDetails = response.data!;
        InterWalletTransferResponse parsedResponse =
            InterWalletTransferResponse(
          status: response.status,
          message: response.message,
          responseCode: response.responseCode,
          data: transactionDetails,
        );
        Get.find<DashboardController>().userWallet();
        Get.offAll(() => ScanToPayReceiptScreen(
              transactionDetails: parsedResponse,
            ));
      } else {
        if (response.responseCode == "11") {
          Get.defaultDialog(
              title: 'Failed',
              content: Text(
                response.message,
                style: const TextStyle(color: Colors.white),
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
