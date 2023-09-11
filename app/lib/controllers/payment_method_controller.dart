import 'package:app/controllers/bloc/payment_controller.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../screens/payments/payment_processing.dart';
import '../services/requests/post_requests/credit_wallet_request.dart';
import '../shareds/constants/key_constants.dart';
import '../widgets/app_dialog.dart';
import '../widgets/app_logo.dart';

class PaymentMethodController extends GetxController {
  late Map<String, dynamic> args;
  late String amount;
  final paymentOption = 'Pay with card'.obs;
  final payWithCard = 'Pay with card'.obs;
  final payWithBank = 'Pay with bank'.obs;

  final accountBalance = 0.obs;
  final paymentReference = ''.obs;
  final paymentEmail = ''.obs;
  final paymentCurrency = ''.obs;
  final isLoaded = false.obs;

  final plugin = PaystackPlugin();
  GetSessionManager session = GetSessionManager();
  PaymentController paymentController = PaymentController();

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    amount = args['amount'];
    plugin.initialize(publicKey: paystackPublicKey);
  }

  void payNow(context) {
    if (paymentOption.value == payWithCard.value) {
      checkoutPaystack(context);
    } else {
      placeHolderDialog(paymentOption.value);
    }
  }

  void checkoutPaystack(BuildContext context) async {
    Get.focusScope!.unfocus();
    isLoaded.value = true;
    int price = int.parse(amount) * 100;
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
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      logo: trowpassLogo(),
    );
    if (response.status == true) {
      Get.focusScope!.unfocus();
      // call our service
      await paymentController.creditWalletAsync(
        CreditWalletRequest(
          amount: int.parse(amount),
          reference: paymentReference.value,
          paymentMethod: 'card',
          email: paymentEmail.value,
          currency: paymentCurrency.value,
        ),
      );
      Get.offAll(() => PaymentProcessing(
            reference: response.reference!,
            companyName: 'Trowpass',
            recipientName: session.readRiderFullName()!,
            amount: double.parse(amount),
          ));
      isLoaded.value = false;
    } else {
      isLoaded.value = false;
    }
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
