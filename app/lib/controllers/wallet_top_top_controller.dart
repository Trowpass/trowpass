import 'package:app/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../screens/wallet/topup/wallet_top_up_payment_options.dart';
import '../shareds/constants/key_constants.dart';
import '../shareds/managers/get_session_manager.dart';

class WalletTopUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final accountBalance = 0.obs;
  final cardDetails = ''.obs;
  final customerName = ''.obs;
  final generateAsteriks = ''.obs;

  final shouldEntryAmountBeCleared = Rx<bool>(false);
  final showAccountBalance = Rx<bool>(false);

  TextEditingController topUpAmountController = TextEditingController();
  final plugin = PaystackPlugin();
  GetSessionManager session = GetSessionManager();
  @override
  void onInit() {
    cardDetails.value = '**** **** **** 123401/24';
    customerName.value = session.readRiderFullName()!.toUpperCase();
    accountBalance.value = 0;
    plugin.initialize(publicKey: paystackPublicKey);
    super.onInit();
  }

  checkout(BuildContext context) async {
    int price = int.parse(topUpAmountController.text) * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
      ..email = session.readRiderEmail()!
      ..currency = "NGN";
    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.card, charge: charge, logo: trowpassLogo());
    if (response.status == true) {
      //process and verify payment
      Get.focusScope!.unfocus();
    } else {}
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

  Widget trowpassLogo() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: appLogo(70, 70),
    );
  }
}
