import 'package:get/get.dart';

class HomeLandingTabController extends GetxController {
  final tabIndex = 0.obs;

  void onChangeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
