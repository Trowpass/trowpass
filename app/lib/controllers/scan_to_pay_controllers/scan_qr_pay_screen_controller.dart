// ignore_for_file: unused_local_variable

import 'package:app/controllers/bloc/inter_wallet_transfer_controller.dart';
import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/controllers/dashboard_conroller.dart';
import 'package:app/screens/send_money/scan_to_pay/receipt.dart';
import 'package:app/services/requests/post_requests/inter_wallet_transfer_request.dart';
import 'package:app/services/responses/inter_wallet_transfer_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
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

  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
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

  Future<void> scanToPay() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      int senderUserId = session.readUserId() as int;
      var response = await interwalletController
          .interWalletTransferAsync(InterWalletTransferRequest(
        senderUserId: senderUserId,
        recipientPhoneNumber: phoneNumberController.text.trim(),
        narration: narrationController.text.trim(),
        amount: int.parse(amountController.text),
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
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
