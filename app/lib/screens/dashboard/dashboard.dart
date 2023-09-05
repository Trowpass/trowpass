// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app/screens/Inter_wallet_pay/pay.dart';
import 'package:app/screens/dashboard/components/custom_card.dart';
import 'package:app/screens/dashboard/components/image_slider.dart';
import 'package:app/screens/scan_to_pay/qr_code.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_conroller.dart';
import '../../widgets/currency_format.dart';
import '../wallet/top_up_transport_wallet.dart';
import '../wallet/topup/wallet_top_up.dart';

class DashboardScreen extends StatelessWidget {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => !controller.isLoaded.value
        ? overlayLoader(!controller.isLoaded.value)
        : RefreshIndicator(
            onRefresh: () async {
              await controller.userWallet();
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: primaryColor,
                statusBarBrightness: Brightness.light, // For iOS
                statusBarIconBrightness: Brightness.light, // For Android
                systemNavigationBarColor: navigationBarBackground,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
              child: Scaffold(
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 55),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Welcome back!',
                                              style: appStyles(16, offWhite,
                                                  FontWeight.w300),
                                            ),
                                            Text(
                                              controller.fullName.value,
                                              style: appStyles(18, offWhite,
                                                  FontWeight.w500),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Obx(
                                                    () => Text(
                                                      controller
                                                              .showBalance.value
                                                          ? '${currencyFormat(context).currencySymbol}${controller.balance.value}'
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
                                                        controller.showBalance
                                                                .value
                                                            ? Icons
                                                                .visibility_off
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                              controller.accountNumber.value,
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
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                CustomCard(
                                  imagePath: scan,
                                  text: 'Scan to Pay',
                                  onTap: () {
                                    Get.to(() => ScanScreen());
                                  },
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
                                  onTap: () {
                                    upComingWidget('Get Transport Loan');
                                  },
                                ),
                                CustomCard(
                                  imagePath: card,
                                  text: 'Transport Card',
                                  onTap: () {
                                    upComingWidget('Transport Card');
                                  },
                                ),
                                CustomCard(
                                  imagePath: book,
                                  text: 'Book a Bus',
                                  onTap: () {
                                    upComingWidget('Book a Bus');
                                  },
                                ),
                                CustomCard(
                                  imagePath: send,
                                  text: 'Send Money',
                                  onTap: () {
                                    Get.to(InterWalletPayScreen());
                                  },
                                ),
                                CustomCard(
                                  imagePath: book,
                                  text: 'Transports Pay',
                                  onTap: () {
                                    upComingWidget('Transports Pay');
                                  },
                                ),
                                CustomCard(
                                  imagePath: flight,
                                  text: 'Book Flight',
                                  onTap: () {
                                    upComingWidget('Book Flight');
                                  },
                                ),
                                CustomCard(
                                  imagePath: train,
                                  text: 'Train Ticket',
                                  onTap: () {
                                    upComingWidget('Train Ticket');
                                  },
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
                    onPressed: () => Get.to(WalletTopUpScreen()),
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            ),
          )));
  }
}

void upComingWidget(dynamic pageTitle) {
  Get.defaultDialog(
      title: pageTitle,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(
            color: background,
          ),
          Text(
              'We have you in mind. In the mean time, explore the available features. Thank you.',
              style: TextStyle(color: background),
              textAlign: TextAlign.center)
        ],
      ),
      middleText: 'Coming Soon!!!',
      backgroundColor: primaryColor,
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      middleTextStyle: TextStyle(color: Colors.white),
      radius: 30);
}
