import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet/top_up_transport_wallet_done.dart';

class PaymentSuccess extends StatelessWidget {
  final String successMessage;
  final String transactionId;
  final String companyName;
  final String recipientName;
  final double amount;
  const PaymentSuccess(
      {super.key,
      required this.successMessage,
      required this.transactionId,
      required this.companyName,
      required this.recipientName,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Image.network(
                      "https://res.cloudinary.com/iamvictorsam/image/upload/v1671834054/Capture_inlcff.png",
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Text(successMessage,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(TopUpTransportWalletDoneScreen(
                              successMessage: successMessage,
                              reference: transactionId,
                              companyName: companyName,
                              recipientName: recipientName,
                              amount: amount,
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5.0),
                          child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text('Payment Summary',
                                  style: TextStyle(fontSize: 20)))),
                    ),
                    const Spacer(),
                  ],
                ))));
  }
}
