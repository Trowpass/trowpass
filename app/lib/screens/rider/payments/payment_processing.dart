import 'package:app/screens/wallet/topup/wallet_top_up.dart';
import 'package:app/screens/wallet/topup/wallet_top_up_done_screen.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/rider/bloc/payment_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/overlay_indeterminate_progress.dart';

class PaymentProcessing extends StatefulWidget {
  final String reference;
  final String companyName;
  final String recipientName;
  final double amount;
  const PaymentProcessing(
      {super.key,
      required this.reference,
      required this.companyName,
      required this.recipientName,
      required this.amount});

  @override
  State<PaymentProcessing> createState() => _PaymentProcessingState();
}

class _PaymentProcessingState extends State<PaymentProcessing> {
  PaymentController paymentController = PaymentController();
  GetSessionManager session = GetSessionManager();

  void verifyOnServer() async {
    Get.focusScope!.unfocus();
    final paymentRef = widget.reference;
    try {
      var response = await paymentController
          .verifyPaystackTransactionAsync(paymentRef.trim());
      if (response.status) {
        Get.offAll(() => WalletTopUpDoneScreen(
              successMessage: 'Payment was successful',
              reference: paymentRef,
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
                  Get.offAll(() => WalletTopUpScreen());
                },
                child: const Text("Try Again"))
          ]),
        );
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    verifyOnServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarBrightness: Brightness.light, // For iOS
        statusBarIconBrightness: Brightness.light, // For Android
        systemNavigationBarColor: navigationBarBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: background,
        body: OverlayIndeterminateProgress(
          isLoading: true,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: Container(),
        ),
      ),
    );
  }
}
