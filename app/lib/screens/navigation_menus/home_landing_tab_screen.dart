import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_landing_tab_controller.dart';
import '../../widgets/bottom_bar_navigation_menu.dart';
import 'bills_tab_screen.dart';
import 'history_tab_screen.dart';
import 'home_tab_screen.dart';
import 'profile_tab_screen.dart';

class HomeLandingTabScreen extends StatelessWidget {
  HomeLandingTabScreen({super.key});

  final controller = Get.put(HomeLandingTabController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLandingTabController>(builder: (controller) {
      return Scaffold(
          body: Obx(() => IndexedStack(
                index: controller.pageIndex.value,
                children: const [
                  HomeTabScreen(),
                  HistoryTabScreen(),
                  BillsTabScreen(),
                  ProfileTabScreen(),
                ],
              )),
          bottomNavigationBar: buildBottomNavigationMenu(
              controller.pageIndex.value, controller.onChangeTabIndex));
    });
  }
}
