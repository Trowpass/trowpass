import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/history_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';

class HistoryTabScreen extends GetView<HistoryTabController> {
  const HistoryTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.title,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "History Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
