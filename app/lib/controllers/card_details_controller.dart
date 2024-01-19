import 'package:app/services/responses/card_details_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  final customerName = ''.obs;
  final pan = ''.obs;
  final cvv = ''.obs;
  final expiryDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments as Data;
    customerName.value = data.name;
    pan.value = data.securedDataDetail?.pan ?? '';
    cvv.value = data.securedDataDetail?.cvv ?? '';
    expiryDate.value = '${data.expiryMonth}/${data.expiryYear}';
  }

  void copyCardDetails(String detail) async {
    ClipboardData data = ClipboardData(text: detail);
    await Clipboard.setData(data);
    Get.snackbar(
      'Success',
      'Card details copied to clipboard',
      backgroundColor: dialogInfoBackground,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
