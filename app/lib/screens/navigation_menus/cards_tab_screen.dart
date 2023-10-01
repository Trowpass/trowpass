import 'package:app/screens/card/card_display.dart';
import 'package:app/screens/card/card_type.dart';
import 'package:app/screens/kyc/tier_upgrade_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/cards_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';

class CardsTabScreen extends StatelessWidget {
  CardsTabScreen({super.key});
  final controller = Get.put(CardsTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: controller.cardDetails.value
            ? CardDisplayScreen()
            : controller.openUpgradeSelection.value
                ? const TierSelectionPage()
                : CardTypeScreen(),
      ),
    );
  }
}
