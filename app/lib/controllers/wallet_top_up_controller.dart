import 'package:app/services/requests/post_requests/credit_wallet_request.dart';
import 'package:app/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../screens/payments/pyament_processing.dart';
import '../screens/wallet/topup/wallet_top_up_payment_options.dart';
import '../shareds/constants/key_constants.dart';
import '../shareds/managers/get_session_manager.dart';
import 'bloc/payment_controller.dart';

class WalletTopUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final accountBalance = 0.obs;
  final cardDetails = ''.obs;
  final customerName = ''.obs;
  final generateAsteriks = ''.obs;
  final paymentReference = ''.obs;
  final paymentEmail = ''.obs;
  final paymentCurrency = ''.obs;

  final shouldEntryAmountBeCleared = Rx<bool>(false);
  final showAccountBalance = Rx<bool>(false);
  final isLoaded = false.obs;

  TextEditingController topUpAmountController = TextEditingController();
  final plugin = PaystackPlugin();
  GetSessionManager session = GetSessionManager();
  PaymentController paymentController = PaymentController();

  @override
  void onInit() {
    isLoaded.value = false;
    cardDetails.value = '**** **** **** 123401/24';
    customerName.value = session.readRiderFullName() != null
        ? session.readRiderFullName()!.toUpperCase()
        : '';
    accountBalance.value = 0;
    plugin.initialize(publicKey: paystackPublicKey);
    super.onInit();
  }

  checkout(BuildContext context) async {
    isLoaded.value = true;
    int price = int.parse(topUpAmountController.text) * 100;
    paymentReference.value = 'ref_${DateTime.now().millisecondsSinceEpoch}';
    paymentEmail.value = session.readRiderEmail() != null
        ? session.readRiderEmail()!
        : 'none@gmail.com';
    paymentCurrency.value = 'NGN';
    Charge charge = Charge()
      ..amount = price
      ..reference = paymentReference.value
      ..email = paymentEmail.value
      ..currency = paymentCurrency.value;
    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.card, charge: charge, logo: trowpassLogo());
    if (response.status == true) {
      Get.focusScope!.unfocus();
      //call our service
      await paymentController.creditWalletAsync(CreditWalletRequest(
          amount: int.parse(topUpAmountController.text),
          reference: paymentReference.value,
          paymentMethod: 'card',
          email: paymentEmail.value,
          currency: paymentCurrency.value));
      Get.to(PyamentProcessing(
        reference: response.reference!,
        companyName: 'Trowpass',
        recipientName: session.readRiderFullName()!,
        amount: double.parse(topUpAmountController.text),
      ));
      isLoaded.value = false;
    } else {
      isLoaded.value = false;
    }
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
      child: activityLogo(70, 70),
    );
  }
}
