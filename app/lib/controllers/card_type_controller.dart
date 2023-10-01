import 'package:app/screens/card/card_display.dart';
import 'package:app/screens/card/get_virtual_card.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:get/get.dart';

import '../widgets/app_dialog.dart';

class CardTypeController extends GetxController {
  final isVirtualCreated = false.obs;
  GetSessionManager session = GetSessionManager();

  @override
  void onInit() {
    isVirtualCardCreated();
    super.onInit();
  }

  void handleVirtualCardPressed() => Get.to(() => GetVirtualCardScreen());
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
    if (session.readVirtualCardCreated()) {
      isVirtualCreated.value = true;
    } else {
      isVirtualCreated.value = false;
    }
  }
}
