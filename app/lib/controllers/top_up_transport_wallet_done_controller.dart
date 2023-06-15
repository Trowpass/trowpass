import 'package:app/shareds/utils/images.dart';
import 'package:get/get.dart';

import '../screens/navigation_menus/home_landing_tab_screen.dart';

class TopUpTransportWalletDoneContoller extends GetxController {
  final transactionId = Rx<String>('');
  final transactionAmount = Rx<double>(0);
  final recipientImage = Rx<String>('');
  final recipientName = Rx<String>('');
  final recipientAccountNumber = Rx<String>('');

  String setTransactionId = '847474847';
  double setTransactionAmount = 5000;
  String setRecipientImage = loginImg;
  String setRecipientName = 'Alfred George';
  String setRecipientAccountNumber = '0011223345';

  @override
  void onInit() {
    transactionAmount.value = setTransactionAmount;
    transactionId.value = setTransactionId;
    recipientImage.value = setRecipientImage;
    recipientName.value = setRecipientName;
    recipientAccountNumber.value = setRecipientAccountNumber;
    super.onInit();
  }

  void trySubmit() {
    Get.to(() => HomeLandingTabScreen());
  }
}
