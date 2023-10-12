import 'package:get/get.dart';

import '../cards_tab_controller.dart';
import '../history_tab_controller.dart';
import '../home_tab_controller.dart';
import '../profile_tab_controller.dart';

class DashboardTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabController());
    Get.lazyPut(() => HistoryTabController());
    Get.lazyPut(() => CardsTabController());
    Get.lazyPut(() => ProfileTabController());
  }
}
