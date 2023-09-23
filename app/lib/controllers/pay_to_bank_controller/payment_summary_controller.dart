import 'package:get/get.dart';

class PaymentSummaryController extends GetxController {
  final paymentMethod = ''.obs;
  final transactionId = ''.obs;
  final amount = ''.obs;

  void initializeData() {
    paymentMethod.value = 'E-Transact';
    transactionId.value = '#21353ADEGRG';
    amount.value = 'N5,000';
  }

  void payNow() {
    // Handle payment logic here
  }
}
