import 'package:get/get.dart';

class WalletTopUpPaymentOptionController extends GetxController {
  final title = Rx<String>('Payment Options');
  final cardType = Rx<String>('');
  final cardPan = Rx<String>('');

  @override
  void onInit() {
    cardType.value = 'Master Card';
    cardPan.value = '123-3454-678-9777-2344';
    super.onInit();
  }

  void trySubmit() {}
}
