// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptController extends GetxController {
  final String recipientName = 'John Doe';
  final String recipientNumber = '1234567890';
  final String amount = '\$100.00'; // Replace with the actual amount
}

class ReceiptScreen extends StatelessWidget {
  final ReceiptController controller = Get.put(ReceiptController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Text('Transfer Receipt',
                  style: appStyles(20, background, FontWeight.w600)),
              const SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  Image.asset(
                    subtract,
                    fit: BoxFit.cover,
                    height: 520,
                    width: double.infinity,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Image.asset(success),
                          SizedBox(height: 20),
                          Text(
                            'Payment Made',
                            style: appStyles(20, titleActive, FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Money successfully sent to',
                              style:
                                  appStyles(16, titleActive, FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Ajakaye Damilola',
                            style: appStyles(16, titleActive, FontWeight.w500),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'N5,000',
                            style: appStyles(24, titleActive, FontWeight.w600),
                          ),
                          SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Recipient',
                                    style: appStyles(
                                        16, titleActive, FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Image.asset(user),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ajakaye Damilola',
                                          style: appStyles(
                                              14, titleActive, FontWeight.w500),
                                        ),
                                        Text(
                                          '07056833529',
                                          style: appStyles(
                                              10, gray, FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                StandardButton(
                                  text: 'Done',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(
//     GetMaterialApp(
//       home: ReceiptScreen(),
//     ),
//   );
// }
