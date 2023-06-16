// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  final selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}

class ScanScreen extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0.0,
        title: Text('Sanwopay QR code',
            style: appStyles(20, titleActive, FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTabButton('My Code', 0),
              ),
              Expanded(
                child: _buildTabButton('Scan', 1),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (controller.selectedIndex.value == 0) {
                return _buildMyCodeTab();
              } else {
                return _buildScanTab();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedIndex.value == index
                    ? line
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: appStyles(
                18,
                controller.selectedIndex.value == index ? line : Colors.black,
                FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

Widget _buildMyCodeTab() {
  return Center(
      child: Column(
    children: [
      SizedBox(
        height: 80,
      ),
      Container(
        width: 297,
        height: 387,
        color: background,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, -190),
              child: ClipOval(
                  child: Image.asset(
                profile,
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Daisy Bright',
                  style: appStyles(
                    20,
                    titleActive,
                    FontWeight.w500,
                  ),
                ),
                Text(
                  'Driver',
                  style: appStyles(
                    20,
                    titleActive,
                    FontWeight.w400,
                  ),
                ),
                Image.asset(
                  code,
                )
              ],
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                SizedBox(width: 5),
                Text(
                  'Share Code',
                  style: appStyles(16, titleActive, FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                  color: Colors.black,
                ),
                SizedBox(width: 5),
                Text(
                  'Save to Gallery',
                  style: appStyles(16, titleActive, FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ));
}

Widget _buildScanTab() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Scan the QR code for customer information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
