// ignore_for_file: prefer_const_constructors

import 'package:app/screens/dashboard/components/custom_card.dart';
import 'package:app/screens/dashboard/components/image_slider.dart';
import 'package:app/screens/send_money/scan_to_pay/qr_code.dart';
import 'package:app/screens/send_money/send_money.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../widgets/currency_format.dart';
import '../navigation_menus/cards_tab_screen.dart';
import '../wallet/top_up_transport_wallet.dart';
import '../wallet/topup/wallet_top_up.dart';

// ignore: use_key_in_widget_constructors
class DashboardScreen extends StatelessWidget {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => !controller.isLoaded.value
        ? overlayLoader(!controller.isLoaded.value)
        : RefreshIndicator(
            onRefresh: () async => await controller.userWallet(),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: primaryColor,
                statusBarBrightness: Brightness.light, // For iOS
                statusBarIconBrightness: Brightness.light, // For Android
                systemNavigationBarColor: navigationBarBackground,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: primaryColor,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 55),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 36),
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
                                                const Text(
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
                                                    Obx(() => Text(
                                                          controller.showBalance
                                                                  .value
                                                              ? '${currencyFormat.currencySymbol}${controller.balance.value}'
                                                              : '*******',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        )),
                                                    Obx(() => IconButton(
                                                          onPressed: controller
                                                              .toggleBalanceVisibility,
                                                          icon: Icon(
                                                            controller
                                                                    .showBalance
                                                                    .value
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                            color: Colors.white,
                                                          ),
                                                        )),
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
                                              const Text(
                                                'Account Number',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Obx(() => controller
                                                      .accountNumber.isNotEmpty
                                                  ? Text(
                                                      controller
                                                          .accountNumber.value,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: controller
                                                                  .isCreatWalletCreated
                                                                  .value ==
                                                              true
                                                          ? null
                                                          : () => controller
                                                              .reCreateWallet(),
                                                      child: Chip(
                                                        elevation: 20,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        backgroundColor: controller
                                                                    .isCreatWalletCreated
                                                                    .value ==
                                                                true
                                                            ? label
                                                            : Colors.yellowAccent[
                                                                100],
                                                        shadowColor:
                                                            Colors.black,
                                                        avatar: controller
                                                                    .isCreatWalletCreated
                                                                    .value ==
                                                                true
                                                            ? CircularProgressIndicator()
                                                            : null,
                                                        label: Text(
                                                          controller.isCreatWalletCreated
                                                                      .value ==
                                                                  true
                                                              ? 'Creating...'
                                                              : 'CREATE',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ), //Text
                                                      ),
                                                    )),
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
                            GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                CustomCard(
                                  imagePath: scan,
                                  color: Color.fromRGBO(46, 189, 77, 0.1),
                                  text: 'Scan to Pay',
                                  onTap: () {
                                    Get.to(() => ScanScreen());
                                  },
                                ),
                                CustomCard(
                                  imagePath: topup,
                                  color: Color.fromRGBO(241, 195, 78, 0.1),
                                  text: 'Topup Transport Wallet',
                                  onTap: () {
                                    Get.to(TopUpTransportWalletScreen());
                                  },
                                ),
                                CustomCard(
                                  imagePath: loan,
                                  color: Color.fromRGBO(9, 44, 247, 0.1),
                                  text: 'Get Transport Loan',
                                  onTap: () =>
                                      controller.displayPlaceholderDialog(
                                          'Get Transport Loan'),
                                ),
                                CustomCard(
                                  imagePath: card,
                                  color: Color.fromRGBO(116, 51, 255, 0.1),
                                  text: 'Transport Card',
                                  onTap: () => Get.to(CardsTabScreen()),
                                ),
                                CustomCard(
                                  imagePath: book,
                                  color: Color.fromRGBO(231, 27, 27, 0.1),
                                  text: 'Book a Bus',
                                  onTap: () => controller
                                      .displayPlaceholderDialog('Book a Bus'),
                                ),
                                CustomCard(
                                  imagePath: send,
                                  text: 'Send Money',
                                  color: Color.fromRGBO(46, 189, 78, 0.1),
                                  onTap: () {
                                    Get.to(SendMoneyScreen());
                                  },
                                ),
                                CustomCard(
                                  imagePath: drop,
                                  color: Color.fromRGBO(241, 195, 78, 0.1),
                                  text: 'Pick n Drop',
                                  onTap: () =>
                                      controller.displayPlaceholderDialog(
                                          'Transports Pay'),
                                ),
                                CustomCard(
                                  imagePath: flight,
                                  color: Color.fromRGBO(9, 44, 247, 0.1),
                                  text: 'Book Flight',
                                  onTap: () => controller
                                      .displayPlaceholderDialog('Book Flight'),
                                ),
                                CustomCard(
                                    imagePath: train,
                                    color: Color.fromRGBO(60, 123, 245, 0.1),
                                    text: 'Train Ticket',
                                    onTap: () =>
                                        controller.displayPlaceholderDialog(
                                            'Train Ticket')),
                              ],
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
                      icon: const Icon(
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
            ),
          ));
  }
}
