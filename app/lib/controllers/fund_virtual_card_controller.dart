import 'package:app/repositories/cards_repository.dart';
import 'package:app/services/requests/post_requests/fund_virtual_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import '../widgets/currency_format.dart';

class FundVirtualCardController extends GetxController {
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final topUpAmountController = TextEditingController();
  final balance = 'Balance: 0.0'.obs;
  final session = GetSessionManager();
  final cardsRepository = CardsRepository();

  @override
  void onInit() {
    super.onInit();
    balance.value = 'Balance: ${ngnFormatCurrency(session.readUserAccountBalance() ?? 0.0)}';
  }

  Future<void> fundVirtualCard() async {
    try {
      isLoading.value = true;
      var response = await cardsRepository.fundVirtualCardAsync(FundVirtualCardRequest(
        fromSourceAccountNumber: session.readUserAccountNumber() ?? '',
        amount: double.parse(topUpAmountController.text),
      ));
      if (response.status && response.data!= null) {
      } else {
        Get.defaultDialog(title: 'Information', content: Text(response.message));
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
