// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app/controllers/dashboard_conroller.dart';
import 'package:app/screens/scan_to_pay/scan.dart';
import 'package:app/screens/scan_to_pay/qr_data.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0.0,
        title: Text('Trowpass QR Code',
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
  final controller = Get.put(DashboardController());
  String fullName = controller.fullName.value;
  String bankName = controller.bankName.value;
  String accountNumber = controller.accountNumber.value;

  UserData userdata = UserData(fullName, bankName, accountNumber);

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
            // Transform.translate(
            //   offset: Offset(0, -190),
            //   child: ClipOval(
            //       child: Image.asset(
            //     profile,
            //   )),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                // Text(
                //   'Daisy Bright',
                //   style: appStyles(
                //     20,
                //     titleActive,
                //     FontWeight.w500,
                //   ),
                // ),
                // Text(
                //   'Driver',
                //   style: appStyles(
                //     20,
                //     titleActive,
                //     FontWeight.w400,
                //   ),
                // ),
                // Image.asset(
                //   code,
                // )
                QrImageView(
                  data:
                      "${userdata.fullName}\n${userdata.bankName}\n${userdata.accountNumber}",
                  version: QrVersions.auto,
                  size: 250.0, // Adjust the size as needed
                  foregroundColor: Colors.black,
                  errorCorrectionLevel: QrErrorCorrectLevel.Q,
                  embeddedImage: AssetImage(mainLogo), // Add your company logo
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(40, 40), // Size of the embedded image
                  ),
                ),
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
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  "Scan the QR code",
                  style: appStyles(16, titleActive, FontWeight.w500),
                ),
                Text(
                  "for customer information",
                  style: appStyles(16, titleActive, FontWeight.w500),
                ),
              ],
            )),
        Expanded(flex: 4, child: QrScanArea()),
        Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.browse_gallery_outlined),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Add code from gallery",
                    style: appStyles(16, grayscale, FontWeight.w500),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}
