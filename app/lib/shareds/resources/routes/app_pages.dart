import 'package:app/screens/auth/login.dart';
import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
