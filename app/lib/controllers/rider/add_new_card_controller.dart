import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../screens/rider/wallet/topup/wallet_top_up_payment_options.dart';

class AddNewCardController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final title = Rx<String>('Add New Card');
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();

  void trySubmit() {
    Get.to(WalletTopUpPaymentOptions());
  }
}
