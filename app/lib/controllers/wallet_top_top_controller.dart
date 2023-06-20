import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../screens/wallet/topup/wallet_top_up_payment_options.dart';

class WalletTopUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final accountBalance = Rx<double>(0);
  final cardDetails = Rx<String>('');
  final customerName = Rx<String>('');
  final generateAsteriks = Rx<String>('');

  final shouldEntryAmountBeCleared = Rx<bool>(false);
  final showAccountBalance = Rx<bool>(false);

  TextEditingController topUpAmountController = TextEditingController();

  @override
  void onInit() {
    cardDetails.value = '**** **** **** 123401/24';
    customerName.value = 'David Morgan'.toUpperCase();
    accountBalance.value = 5000;

    super.onInit();
  }

  void trySubmit() {
    Get.focusScope!.unfocus();
    Get.to(WalletTopUpPaymentOptions());
  }

  void clearTopUpAmount() {
    if (shouldEntryAmountBeCleared.isTrue) {
      topUpAmountController.clear();
    } else {
      shouldEntryAmountBeCleared.value = false;
    }
  }

  String hideAccountBalance() {
    int balanceLen = accountBalance.value.toString().length;
    return generateAsteriks.value =
        List.generate(balanceLen, (index) => '*').join();
  }

  final pageIndex = 0.obs;
  void onChangeTabIndex(int index) {
    pageIndex.value = index;
    update();
  }
}
