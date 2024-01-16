import 'package:app/screens/wallet/topup/add_new_card.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/wallet_top_up_payment_option_contoller.dart';
import '../../../shareds/utils/border_radius.dart';
import '../top_up_transport_wallet_summary.dart';

class WalletTopUpPaymentOptions extends StatelessWidget {
  WalletTopUpPaymentOptions({super.key});

  final controller = Get.put(WalletTopUpPaymentOptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        title: Text(controller.title.value),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose Cards',
                    textAlign: TextAlign.left,
                    style: appStyles(20, null, FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Get.to(TopUpTransportWalletSummaryScreen()),
                    child: Card(
                      elevation: 0,
                      shadowColor: grayscale,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(masterCard),
                        title: Text(
                          controller.cardType.value,
                          style: appStyles(18, null, FontWeight.w500),
                        ),
                        subtitle: Text(controller.cardPan.value, style: appStyles(16, null, FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
                        backgroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 70),
                        side: const BorderSide(color: primaryColor),
                      ),
                      onPressed: () => Get.to(AddNewCardScreen()),
                      icon: const Icon(Icons.queue_rounded),
                      label: Text('Add Card', style: appStyles(16, null, FontWeight.w500)))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Others',
                    textAlign: TextAlign.left,
                    style: appStyles(20, null, FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    shadowColor: grayscale,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: primaryColor),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.qr_code_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Scan Bar Code',
                        style: appStyles(18, null, FontWeight.w500),
                      ),
                      subtitle: Text('Scan bar code to pay', style: appStyles(16, null, FontWeight.w400)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    shadowColor: grayscale,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: primaryColor),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.phone_iphone_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Phone Number',
                        style: appStyles(18, null, FontWeight.w500),
                      ),
                      subtitle: Text('Pay directly to a phone number', style: appStyles(16, null, FontWeight.w400)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    shadowColor: grayscale,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: primaryColor),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.store_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Bank Account',
                        style: appStyles(18, null, FontWeight.w500),
                      ),
                      subtitle: Text('Pay directly to bank account', style: appStyles(16, null, FontWeight.w400)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
