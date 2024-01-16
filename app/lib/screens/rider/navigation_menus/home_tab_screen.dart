import 'package:app/screens/rider/dashboard/dashboard.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/home_tab_controller.dart';

class HomeTabScreen extends GetView<HomeTabController> {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: DashboardScreen(),
    );
  }
}
