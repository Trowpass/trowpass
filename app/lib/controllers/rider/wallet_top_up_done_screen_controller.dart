import 'package:app/shareds/utils/images.dart';
import 'package:get/get.dart';

import '../../screens/navigation_menus/home_landing_tab_screen.dart';

class WalletTopUpDoneScreenContoller extends GetxController {
  final transactionId = Rx<String>('');
  final transactionAmount = Rx<double>(0);
  final recipientImage = Rx<String>('');
  final recipientName = Rx<String>('');
  final companyName = Rx<String>('');
  final recipientAccountNumber = Rx<String>('');

  String setTransactionId = '847474847';
  String setRecipientImage = paymentImg;
  String setRecipientName = 'Alfred George';
  String setRecipientAccountNumber = '0011223345';

  @override
  void onInit() {
    transactionId.value = setTransactionId;
    recipientImage.value = setRecipientImage;
    recipientName.value = setRecipientName;
    recipientAccountNumber.value = setRecipientAccountNumber;
    super.onInit();
  }

  void trySubmit() {
    Get.focusScope!.unfocus();
    Get.offAll(() => HomeLandingTabScreen());
  }
}
