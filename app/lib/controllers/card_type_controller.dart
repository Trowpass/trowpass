import 'package:app/controllers/bloc/card_controller.dart';
import 'package:app/screens/card/card_display.dart';
import 'package:app/screens/card/success_screen.dart';
import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/services/requests/post_requests/create_virtual_card_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_dialog.dart';

class CardTypeController extends GetxController {
  final isVirtualCreated = false.obs;
  final cardController = CardController();
  final isLoading = false.obs;
  final getSession = GetSessionManager();
  SetSessionManager setSession = SetSessionManager();

  @override
  void onInit() {
    isLoading.value = false;
    isVirtualCardCreated();
    super.onInit();
  }

  void handleVirtualCardDetains() => Get.to(() => CardDisplayScreen());

  Future<void> handlePhysicalCardPressed() {
    // Please note: the screen for this have already been created in GetPhysicalCardScreen, which is in the same
    // directory as the GetVirtualCardScreen. Just replace this dialog with the navigation to that screen and
    // continue from there
    return showAppDialog(
      title: 'Coming soon',
      subtitle:
          'We have you in mind. In the main time, create a virtual card to spend on transport fare.',
      type: DialogType.warning,
    );
  }

  void redirectVirtualCardPressed() {
    if (isVirtualCreated.value = true) {}
  }

  void isVirtualCardCreated() {
    if (getSession.readVirtualCardCreated()) {
      isVirtualCreated.value = true;
    } else {
      isVirtualCreated.value = false;
    }
  }

  Future<void> createVirtualCard() async {
    isLoading.value = true;
    Get.focusScope!.unfocus();
    try {
      int? userId = getSession.readUserId();
      final response = await cardController
          .createVirtualCardAsync(CreateVirtualCardRequest(userId: userId));
      if (response.status) {
        isLoading.value = false;
        setSession.writeVirtualCardCreated(true);
        Get.to(() => SuccessScreen(
              message: 'Congratulations your card has been created!',
              imageAsset: cardSuccess,
              onTap: () => Get.offAll(() => const HomeLandingTabScreen()),
            ));
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
