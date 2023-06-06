import 'package:app/screens/navigation_menus/profile_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_landing_tab_controller.dart';
import '../../widgets/bottom_bar_navigation_menu.dart';
import 'bills_tab_screen.dart';
import 'history_tab_screen.dart';
import 'home_tab_screen.dart';

class HomeLandingTabScreen extends StatelessWidget {
  const HomeLandingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLandingTabController>(builder: (controller) {
      return SafeArea(
          child: Scaffold(
              body: Obx(() => IndexedStack(
                    index: controller.tabIndex.value,
                    children: const [
                      HomeTabScreen(),
                      HistoryTabScreen(),
                      BillsTabScreen(),
                      ProfileTabScreen(),
                    ],
                  )),
              bottomNavigationBar: buildBottomNavigationMenu(
                  controller.tabIndex.value, controller.onChangeTabIndex)));
    });
  }
}
