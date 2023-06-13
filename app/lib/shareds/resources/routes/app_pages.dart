import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import '../../../screens/wallet/top_up_wallet.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => TopUpWalletScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
