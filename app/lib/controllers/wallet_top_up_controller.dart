import 'package:app/widgets/fund_options_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/payments/payment_method.dart';
import '../screens/wallet/topup/wallet_top_up_payment_options.dart';
import '../shareds/managers/get_session_manager.dart';

class WalletTopUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final accountBalance = 0.obs;
  final cardDetails = ''.obs;
  final customerName = ''.obs;
  final generateAsterisk = ''.obs;

  final shouldEntryAmountBeCleared = Rx<bool>(false);
  final showAccountBalance = Rx<bool>(false);
  final isLoaded = false.obs;

  final session = GetSessionManager();

  TextEditingController topUpAmountController = TextEditingController();

  @override
  void onInit() {
    isLoaded.value = false;
    cardDetails.value = '**** **** **** 123401/24';
    accountBalance.value = 0;
    customerName.value = session.readRiderFullName() ?? '';
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
    return generateAsterisk.value =
        List.generate(balanceLen, (index) => '*').join();
  }

  final pageIndex = 0.obs;
  void onChangeTabIndex(int index) {
    pageIndex.value = index;
    update();
  }

  void proceedFundWallet(BuildContext context) {
    showFundOptionsBottomSheet(
      context,
      bankName: session.readUserBankName() ?? '',
      accountNumber: session.readUserAccountNumber() ?? '',
      onOtherOptionsTap: () {
        final amount = topUpAmountController.text;
        Get.to(() => PaymentMethodScreen(),
            fullscreenDialog: true, arguments: {'amount': amount});
      },
    );
  }
}
