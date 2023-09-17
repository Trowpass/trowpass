import 'package:app/widgets/currency_format.dart';
import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';
import '../shareds/utils/images.dart';

class CardDisplayController extends GetxController {
  final isLoading = false.obs;
  final balance = ''.obs;
  final customerName = ''.obs;
  final expiryDate = '05/24'.obs;
  final cardNumber = '1234 ******* 3456'.obs;
  final session = GetSessionManager();
  final cardType = verveCard.obs;

  @override
  void onInit() {
    super.onInit();
    balance.value = ngnFormatCurrency(0);
    customerName.value = (session.readRiderFullName() ?? '').toUpperCase();
  }
}
