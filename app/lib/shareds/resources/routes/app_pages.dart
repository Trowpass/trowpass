import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import '../../../screens/auth/account_type_screen.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const AccountTypeScreen(),
      // page: () => OnBoardingScreen(),
      // page: () => HomeLandingTabScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
