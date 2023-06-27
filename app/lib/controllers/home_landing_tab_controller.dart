import 'package:get/get.dart';

class HomeLandingTabController extends GetxController {
  final pageIndex = 0.obs;

  void onChangeTabIndex(int index) {
    pageIndex.value = index;
    update();
  }
}
