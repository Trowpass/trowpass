import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/top_up_transport_wallet_done_controller.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/standard_button.dart';

class TopUpTransportWalletDoneScreen extends StatelessWidget {
  TopUpTransportWalletDoneScreen({super.key});
  final controller = Get.put(TopUpTransportWalletDoneContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Receipt',
                      style: appStyles(20, Colors.white, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                        elevation: 5,
                        shadowColor: primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Image.asset(successImg),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                'Payment Successful',
                                style: appStyles(16, null, FontWeight.bold),
                                textScaleFactor: 1.2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                title: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Company name wallet top up successful',
                                    style: appStyles(16, null, null),
                                  ),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Trans ID: ${controller.transactionId.value}'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                                  '${currencyFormat(context).currencySymbol}${formatCurrency(controller.transactionAmount.value)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(-20, 0),
                                        child: const CircleAvatar(
                                          backgroundColor: primaryColor,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(20, 0),
                                        child: const CircleAvatar(
                                            backgroundColor: primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Transform.translate(
                                    offset: const Offset(0, 40),
                                    child: const DottedLine(
                                      dashColor: grayscale,
                                      dashLength: 10,
                                      dashGapLength: 3,
                                      lineThickness: 2,
                                      dashRadius: 1,
                                      lineLength: 330,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Recipient',
                                        style: appStyles(
                                            20, null, FontWeight.bold),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Expanded(
                                            flex: 1,
                                            child: Image.asset(
                                                controller.recipientImage.value,
                                                height: 70,
                                                width: 70)),
                                      ),
                                      Expanded(
                                          child: ListTile(
                                              title: Text(controller
                                                  .recipientName.value),
                                              subtitle: Text(controller
                                                  .recipientAccountNumber
                                                  .value)))
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: StandardButton(
                                        text: 'Done',
                                        onPressed: () {
                                          controller.trySubmit();
                                        },
                                      ))
                                ]),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, 20),
                              child: const DottedLine(
                                dashColor: primaryColor,
                                dashGapRadius: 20,
                                dashGapLength: 5,
                                dashLength: 20,
                                lineThickness: 30,
                                dashRadius: 20,
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
