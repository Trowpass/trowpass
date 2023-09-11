import 'package:app/screens/get_transport_card/get_virtual_card.dart';
import 'package:get/get.dart';

import '../widgets/app_dialog.dart';

class CardTypeController extends GetxController {
  void handleVirtualCardPressed() => Get.to(() => GetVirtualCardScreen());

  Future<void> handlePhysicalCardPressed() {
    return showAppDialog(
      title: 'Coming soon',
      subtitle: 'We have you in mind. In the main time, create a virtual card to spend on transport fare.',
      type: DialogType.warning,
    );
  }
}
