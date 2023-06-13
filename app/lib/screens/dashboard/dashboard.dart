// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app/screens/dashboard/components/custom_card.dart';
import 'package:app/screens/dashboard/components/image_slider.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet/top_up_transport_wallet.dart';

class DashboardController extends GetxController {
  var showBalance = true.obs;

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }
}

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back!',
                                      style: appStyles(
                                          16, offWhite, FontWeight.w300),
                                    ),
                                    Text(
                                      'Damilola',
                                      style: appStyles(
                                          18, offWhite, FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(qrCode),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 36),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Balance',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => Text(
                                              controller.showBalance.value
                                                  ? 'N12,500.00'
                                                  : '*******',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => IconButton(
                                              onPressed: controller
                                                  .toggleBalanceVisibility,
                                              icon: Icon(
                                                controller.showBalance.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Account Number',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      '4326290835',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    child: GridView.count(
                      crossAxisCount: 3, // Number of columns
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CustomCard(
                          imagePath: scan,
                          text: 'Scan to Pay',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: topup,
                          text: 'Topup Transport Wallet',
                          onTap: () {
                            Get.to(TopUpTransportWalletScreen());
                          },
                        ),
                        CustomCard(
                          imagePath: loan,
                          text: 'Get Transport Loan',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: card,
                          text: 'Transport Card',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: book,
                          text: 'Book a Bus',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: send,
                          text: 'Send Money',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: book,
                          text: 'Transports Pay',
                          onTap: () {},
                        ),
                        CustomCard(
                          imagePath: flight,
                          text: 'Book Flight',
                          onTap: () {
                            // Handle card 8 tap
                          },
                        ),
                        CustomCard(
                          imagePath: train,
                          text: 'Train Ticket',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ImageSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GetBuilder<DashboardController>(
        builder: (controller) {
          return FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: primaryColor,
            icon: Icon(
              Icons.add,
              color: background,
            ),
            label: Text(
              'Topup Wallet',
              style: appStyles(12, background, FontWeight.w400),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
