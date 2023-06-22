import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import '../../../screens/navigation_menus/home_landing_tab_screen.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => HomeLandingTabScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
