import 'package:app/screens/card/copy_card_details.dart';
import 'package:app/services/responses/card_details_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/currency_format.dart';
import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../repositories/cards_repository.dart';
import '../shareds/managers/get_session_manager.dart';

class CardDisplayController extends GetxController {
  final isLoading = false.obs;
  final balance = ''.obs;
  final customerName = ''.obs;
  final expiryDate = ''.obs;
  final cardNumber = '****************'.obs;
  final cardType = ''.obs;
  final cvv = '***'.obs;
  final pan = ''.obs;
  final cardRevealBtnText = 'Show details';
  late Data? fullCardDetails;

  final session = GetSessionManager();
  final cardsRepository = CardsRepository();

  @override
  void onInit() {
    super.onInit();
    getCardDetails();
  }

  Future<void> getCardDetails() async {
    try {
      isLoading.value = true;
      var response = await cardsRepository.getCardDetailsAsync();
      if (response.status && response.data != null) {
        fullCardDetails = response.data;
        final data = response.data!;
        customerName.value = data.name;
        expiryDate.value = '${data.expiryMonth}/${data.expiryYear}';
        balance.value = ngnFormatCurrency(data.balance);
        cardNumber.value = data.pan;
        cvv.value = data.securedDataDetail?.cvv ?? '';
        pan.value = data.securedDataDetail?.pan ?? '';

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
      }
      isLoading.value = false;
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

  void showCardDetails() {
    Get.to(() => CopyCardDetailsScreen(), arguments: fullCardDetails);
  }
}
