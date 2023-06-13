import 'package:get/get.dart';

import '../../../controllers/bindings/dashboard_tab_binding.dart';
import '../../../screens/wallet/top_up_transport_wallet_summary.dart';
import 'app_reoutes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.login,
      page: () => TopUpTransportWalletSummaryScreen(),
      binding: DashboardTabBinding(),
    ),
  ];
}
