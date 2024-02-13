import 'package:app/controllers/rider/card_display_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'fund_virtual_card.dart';

class CardDisplayScreen extends StatelessWidget {
  final controller = Get.put(CardDisplayController());
  CardDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Virtual Card',
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
        actions: const <Widget>[],
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () async => await controller.getCardDetails(),
            child: OverlayIndeterminateProgress(
              isLoading: controller.isLoading.value,
              progressColor: primaryColor,
              overlayBackgroundColor: background,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildCardDisplay(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: StandardButton(
                        text: controller.cardRevealBtnText,
                        onPressed: controller.showCardDetails,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          controller.balance.value,
                          style: appStyles(32, titleActive, FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text('Balance',
                            style: appStyles(18, null, FontWeight.w400)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TransparentButton(
                      text: 'Add Money',
                      icon: const Icon(
                        Icons.add,
                        color: titleActive,
                      ),
                      onTap: () => Get.to(() => FundVirtualCardScreen()),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildCardDisplay() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Image.asset(blueCard, scale: 1.2),
          Positioned(
            top: 0,
            left: 0,
            child: appLogo(100, 100),
          ),
          Positioned(
            top: 8,
            right: 0,
            child: Image.asset(wifi, scale: 1.7),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.cardNumber.value,
                  style: appStyles(18, Colors.white, FontWeight.bold),
                ),
                const SizedBox(height: 32),
                RichText(
                  text: TextSpan(
                    style: appStyles(18, Colors.white, null),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Expiry    ',
                        style: appStyles(18, Colors.white, null),
                      ),
                      TextSpan(
                        text: controller.expiryDate.value,
                        style: appStyles(18, Colors.white, FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  controller.customerName.value,
                  style: appStyles(18, Colors.white, FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: appStyles(18, Colors.white, null),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'CVV    ',
                        style: appStyles(18, Colors.white, null),
                      ),
                      TextSpan(
                        text: controller.cvv.value,
                        style: appStyles(18, Colors.white, FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                  visible: controller.cardType.value.isNotEmpty,
                  child: Image.asset(
                    controller.cardType.value,
                    scale: 1.2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
