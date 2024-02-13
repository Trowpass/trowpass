import 'package:app/controllers/rider/bloc/card_controller.dart';
import 'package:app/screens/rider/card/card_display.dart';
import 'package:app/screens/rider/card/success_screen.dart';
import 'package:app/services/requests/rider/post_requests/fund_virtual_card.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shareds/managers/rider/get_session_manager.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/currency_format.dart';

class FundVirtualCardController extends GetxController {
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final topUpAmountController = TextEditingController();
  final balance = 'Balance: 0.0'.obs;
  final session = GetSessionManager();
  CardController cardController = CardController();

  @override
  void onInit() {
    super.onInit();
    balance.value =
        'Wallet Balance: ${ngnFormatCurrency(session.readUserAccountBalance() ?? 0.0)}';
  }

  Future<void> fundVirtualCard() async {
    final text = topUpAmountController.text;
    try {
      //validate funding
      var walletBalance = session.readUserAccountBalance() ?? 0.0;
      if (walletBalance < int.parse(text)) {
        Get.snackbar(
          'Information',
          'Insufficient wallet balance',
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        isLoading.value = true;
        var response =
            await cardController.fundVirtualCardAsync(FundVirtualCardRequest(
          userId: session.readUserId(),
          amount: int.parse(text),
        ));
        if (response.status) {
          final message =
              '${ngnFormatCurrency(double.parse(text))} was added to your card';
          Get.to(() => SuccessScreen(
                message: message,
                imageAsset: fundCardSuccess,
                onTap: () => Get.to(() => CardDisplayScreen()),
              ));
          isLoading.value = false;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
          isLoading.value = false;
        }
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
