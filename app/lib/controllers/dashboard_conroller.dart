import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');

  GetSessionManager session = GetSessionManager();
  @override
  void onInit() {
    userName.value = session.readUserFirstName();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }
}
