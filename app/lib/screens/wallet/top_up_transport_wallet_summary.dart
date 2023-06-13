import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/top_up_transport_wallet_summary_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/images.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/standard_button.dart';

class TopUpTransportWalletSummaryScreen extends StatelessWidget {
  TopUpTransportWalletSummaryScreen({super.key});
  final controller = Get.put(TopUpTransportWalletSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title.value),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(paymentSummary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 2),
                child: Text(
                  'E-Transact',
                  style: appStyles(16, null, FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  controller.paymentId.value,
                  style: appStyles(16, null, FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  '${currencyFormat(context).currencySymbol}${formatCurrency(controller.amount.value)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: StandardButton(
                    text: 'Pay Now',
                    onPressed: () {
                      controller.trySubmit();
                    },
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
