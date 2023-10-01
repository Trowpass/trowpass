import 'package:app/shareds/constants/key_constants.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:get/get.dart';

class CardsTabController extends GetxController {
  final isAccountT1 = false.obs;
  final cardDetails = false.obs;
  final upgraded = false.obs;
  final openUpgradeSelection = false.obs;

  GetSessionManager session = GetSessionManager();

  @override
  void onInit() {
    cardDetails.value = false;
    upgraded.value = false;
    openUpgradeSelection.value = false;
    setInitialScreen();
    super.onInit();
  }

  void setInitialScreen() {
    String accountType = session.readAccountType();
    if (session.readVirtualCardCreated()) {
      cardDetails.value = true;
    } else {
      cardDetails.value = false;
    }
    if (accountType.isNotEmpty && accountType != t1_account) {
      openUpgradeSelection.value = true;
    } else {
      openUpgradeSelection.value = false;
    }
  }
}
