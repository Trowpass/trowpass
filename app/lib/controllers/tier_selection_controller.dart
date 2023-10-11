import 'package:get/get.dart';

import '../shareds/constants/key_constants.dart';
import '../shareds/managers/get_session_manager.dart';

class TierSelectionController extends GetxController {
  bool isT1Done = false;
  bool isT2Done = false;
  bool isT3Done = false;
  bool isDefault = false;
  GetSessionManager session = GetSessionManager();

  @override
  void onInit() {
    super.onInit();

    String accountType = session.readAccountType();
    switch (accountType) {
      case t1Account:
        isT1Done = true;
        break;
      case t2Account:
        isT2Done = true;
        break;
      case t3Account:
        isT3Done = true;
        break;
      default:
        isDefault = true;
        break;
    }
  }
}
