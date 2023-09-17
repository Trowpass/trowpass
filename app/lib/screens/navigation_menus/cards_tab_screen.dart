import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/cards_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../card/card_display.dart';
import '../card/card_type.dart';

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
        child: Obx(() => OverlayIndeterminateProgress(
              progressColor: primaryColor,
              isLoading: controller.isLoading.value,
              overlayBackgroundColor: background,
              child: Visibility(
                visible: !controller.isLoading.value,
                child: controller.isVirtualCardCreated.value ? CardDisplayScreen() : CardTypeScreen(),
              ),
            )),
      ),
    );
  }
}
