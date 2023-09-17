import 'package:app/widgets/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/cards_repository.dart';
import '../shareds/managers/get_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import '../shareds/utils/images.dart';

class CardDisplayController extends GetxController {
  final isLoading = false.obs;
  final balance = ''.obs;
  final customerName = ''.obs;
  final expiryDate = ''.obs;
  final cardNumber = '****************'.obs;
  final cardType = ''.obs;
  final cardsRepository = CardsRepository();
  final session = GetSessionManager();

  @override
  void onInit() {
    super.onInit();
    balance.value = ngnFormatCurrency(0);
    customerName.value = (session.readRiderFullName() ?? '').toUpperCase();
    getCardDetails();
  }

  Future<void> getCardDetails() async {
    try {
      isLoading.value = true;
      var response = await cardsRepository.getCardDetailsAsync();
      if (response.status && response.data != null) {
        final data = response.data!;
        expiryDate.value = '${data.expiryMonth}/${data.expiryYear}';
        balance.value = ngnFormatCurrency(data.balance);
        cardNumber.value = data.encPan;
        switch (data.brand.toLowerCase()) {
          case 'verve':
            cardType.value = verveCard;
            break;
          case 'mastercard':
            cardType.value = masterCard;
            break;
          case 'visa':
            cardType.value = visaCard;
            break;
          default:
        }
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
