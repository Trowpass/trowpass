import 'package:app/screens/onboarding/onboarding_screen.dart';
import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnBoardingScreen(),
      // page: () => HomeLandingTabScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
