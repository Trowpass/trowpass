import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import '../../../screens/auth/login.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      // page: () => LoginScreen(),
      // page: () => HomeLandingTabScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
