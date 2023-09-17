import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/cards_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_styles.dart';
import '../get_transport_card/card_display.dart';
import '../get_transport_card/card_type.dart';

class CardsTabScreen extends StatelessWidget {
  CardsTabScreen({super.key});
  final controller = Get.put(CardsTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        title: Text(
          controller.title.value,
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Obx(() => OverlayIndeterminateProgress(
            progressColor: primaryColor,
            isLoading: controller.isLoading.value,
            overlayBackgroundColor: background,
            child: Visibility(
              visible: controller.isLoading.value,
              child: controller.shouldCreate.value ? CardTypeScreen() : CardDisplayScreen(),
            ),
          )),
    );
  }
}
