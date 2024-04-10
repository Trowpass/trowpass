// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:app/screens/fleet_manager/dashboard/dashboard.dart';
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
