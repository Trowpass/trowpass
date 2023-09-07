import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:get/get.dart';

import '../screens/auth/login.dart';
import '../shareds/managers/set_session_manager.dart';

class UserProfileController extends GetxController {
  final title = Rx<String>('Profile');
  final fullName = Rx<String>('');

  GetSessionManager session = GetSessionManager();
  SetSessionManager session2 = SetSessionManager();

  @override
  void onInit() {
    fullName.value = session.readRiderFullName() ?? '';
    super.onInit();
  }

  void logout() {
    session2.writeIsUserLoggedIn(false);
    Get.offAll(LoginScreen());
  }
}
