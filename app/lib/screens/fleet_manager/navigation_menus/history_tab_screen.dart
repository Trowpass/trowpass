// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/history/history_tab_controller.dart';
import '../../../shareds/utils/app_colors.dart';

class HistoryTabScreen extends GetView<HistoryTabController> {
  const HistoryTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Text("Hello Fleet Manager History is here"),
          ),
        ],
      ),
    );
  }
}
