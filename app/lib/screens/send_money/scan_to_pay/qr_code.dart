import 'package:app/controllers/dashboard_controller.dart';
import 'package:app/screens/send_money/scan_to_pay/scan.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/empty_placeholder.dart';
import 'package:app/widgets/transparent_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  final selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}

class ScanScreen extends StatelessWidget {
  ScanScreen({super.key});

  final dashboardController = Get.put(DashboardController());
  final scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        centerTitle: true,
        elevation: 0.0,
        title: Text('Trowpass QR Code', style: appStyles(20, titleActive, FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
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
              if (scanController.selectedIndex.value == 0) {
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

  Widget _buildMyCodeTab() {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.3),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Visibility(
                        visible: dashboardController.isQRCodeLoading.value,
                        child: SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                              const SizedBox(height: 16),
                              Text('Retrieving QR Code...', style: appStyles(18, null, null)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !dashboardController.isQRCodeLoading.value,
                        child: CachedNetworkImage(
                          height: 350,
                          width: double.infinity,
                          imageUrl: dashboardController.qrCodeUrl.value,
                          placeholder: (_, __) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                              const SizedBox(height: 16),
                              Text('Displaying QR Code...', style: appStyles(18, null, null)),
                            ],
                          ).paddingAll(100),
                          errorWidget: (_, __, ___) => _buildQRCodeErrorWidget(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).paddingAll(16),
            Column(
              children: [
                const SizedBox(height: 8),
                Visibility(
                  visible: dashboardController.qrCodeUrl.value.isNotEmpty,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Share Code',
                          style: appStyles(16, titleActive, FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Save to Gallery',
                          style: appStyles(16, titleActive, FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanTab() {
    return Column(
      children: [
        const SizedBox(height: 10),
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
          ),
        ),
        Expanded(flex: 4, child: QrScanArea()),
        Expanded(
          flex: 1,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(galleryIcon),
                const SizedBox(width: 10.0),
                Text(
                  "Add code from gallery",
                  style: appStyles(16, grayscale, FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => scanController.selectTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: scanController.selectedIndex.value == index ? line : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: appStyles(
              18,
              scanController.selectedIndex.value == index ? line : Colors.black,
              FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodeErrorWidget() {
    return Column(
      children: [
        const EmptyPlaceholder(
          text: 'Can\'t load your QR code',
        ),
        const SizedBox(height: 18),
        TransparentButton(
          icon: const Icon(
            Icons.refresh,
            size: 24,
          ),
          text: 'Try again',
          onTap: dashboardController.refreshQRCode,
        ),
      ],
    );
  }
}
