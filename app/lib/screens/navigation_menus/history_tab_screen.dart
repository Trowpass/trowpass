import 'package:app/screens/history/history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/history_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';

class HistoryTabScreen extends GetView<HistoryTabController> {
  const HistoryTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: HistoryScreen(),
    );
  }
}
