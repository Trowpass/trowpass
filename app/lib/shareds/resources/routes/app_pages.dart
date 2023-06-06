import 'package:app/views/home.dart';
import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => const Home(),
      // page: () => const LoginScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
