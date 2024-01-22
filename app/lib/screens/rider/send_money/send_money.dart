import 'package:app/screens/rider/send_money/Inter_wallet_pay/pay.dart';
import 'package:app/screens/rider/send_money/pay_to_bank/pay.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/heneficiaries_controller.dart';

class SendMoneyScreen extends StatelessWidget {
  SendMoneyScreen({super.key});
  final controller = Get.put(BeneficiariesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: background,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: background,
            statusBarBrightness: Brightness.dark, // For iOS
            statusBarIconBrightness: Brightness.dark, // For Android
            systemNavigationBarColor: navigationBarBackground,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          title: Text(
            "Send Money",
            style: appStyles(18, titleActive, FontWeight.w500),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: background,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.to(InterWalletPayScreen()),
                  child: Card(
                    color: Colors.white,
                    elevation: 0.7,
                    shadowColor: titleActive,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      leading: Image.asset(trowpass),
                      title: Text(
                        "Trowpass",
                        style: appStyles(16, titleActive, FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(PayToBankScreen()),
                  child: Card(
                    color: Colors.white,
                    elevation: 0.7,
                    shadowColor: titleActive,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      leading: Image.asset(bank),
                      title: Text(
                        "Bank Account",
                        style: appStyles(16, titleActive, FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
