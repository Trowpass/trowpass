import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final title = Rx<String>('Profile');
  final fullName = Rx<String>('');

  GetSessionManager session = GetSessionManager();
  @override
  void onInit() {
    fullName.value = session.readRiderFullName() ?? '';
    super.onInit();
  }
}
