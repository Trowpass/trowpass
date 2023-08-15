import 'package:app/screens/wallet/topup/wallet_top_up.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../controllers/bloc/payment_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_logo.dart';
import '../wallet/top_up_transport_wallet_done.dart';

class PyamentProcessing extends StatefulWidget {
  final String reference;
  final String companyName;
  final String recipientName;
  final double amount;
  const PyamentProcessing(
      {super.key,
      required this.reference,
      required this.companyName,
      required this.recipientName,
      required this.amount});

  @override
  State<PyamentProcessing> createState() => _PyamentProcessingState();
}

class _PyamentProcessingState extends State<PyamentProcessing> {
  PaymentController paymentController = PaymentController();
  GetSessionManager session = GetSessionManager();

  void verifyOnServer() async {
    final paymentRef = widget.reference;
    try {
      var response = await paymentController
          .verifyPaystackTransactionAsync(paymentRef.trim());
      if (response.status) {
        // call wallet top here
        // var topupResponse = await paymentController.topUpWalletAsync(
        //     TopUpWalletRequest(
        //         accountNumber: session.readRiderAccountNumber()!,
        //         amount: widget.amount.toInt()));

        Get.to(TopUpTransportWalletDoneScreen(
          successMessage: 'Payment was successful',
          reference: paymentRef,
          companyName: widget.companyName,
          recipientName: widget.recipientName,
          amount: widget.amount,
        ));
      } else {
        AlertDialog(
          title: const Text("Payment"),
          content: Column(children: [
            const Divider(),
            const Text("Payment was not successful"),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  Get.to(WalletTopUpScreen());
                },
                child: const Text("Try Again"))
          ]),
        );
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
    }

    // String url = 'https://api.paystack.co/transaction/verify/$paymentRef';
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer sk_test_6ed5df9f0a0ac777a2c75b3f557511a6cfe8fd8b'
    // };
    // http.Response response = await http.get(Uri.parse(url), headers: headers);
    // final Map body = json.decode(response.body);
    // if (body['data']['status'] == 'success') {
    // } else {}
  }

  @override
  void initState() {
    verifyOnServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: OverlayLoaderWithAppIcon(
        isLoading: true,
        overlayBackgroundColor: background,
        circularProgressColor: primaryColor,
        appIcon: appLogo(70, 70),
        child: Container(),
      ),
    );
  }
}
