import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';

class ViewUserQRCodeController extends GetxController {
  final qrCode = Rx<String>('');

  GetSessionManager session = GetSessionManager();
  @override
  void onInit() {
    qrCode.value = session.readRiderQRCode();
    super.onInit();
  }
}
