import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import '../../shareds/utils/app_info.dart';

import '../../shareds/helpers/api_connection_helper.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_dialog.dart';
import '../bloc/user_controller.dart';

class QrScanController extends GetxController {
  final apiConnectionHelper = ApiConnectionHelper();
  Rx<Barcode?> result = Rx<Barcode?>(null);
  final selectedIndex = 0.obs;
  final isProcessingShare = false.obs;
  final isQRCodeLoading = true.obs;
  final qrCodeUrl = Rx<String>('');
  final userController = UserController();
  final qrCodeKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    refreshQRCode();
  }

  void setResult(Barcode? newResult) {
    result.value = newResult;
  }

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  void refreshQRCode() async {
    isQRCodeLoading.value = true;
    try {
      var response = await userController.userProfileAsync();
      if (response.status && response.data?.qr != null) {
        qrCodeUrl.value = response.data!.qr!;
      }
    } on Exception catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isQRCodeLoading.value = false;
    }
  }

  void shareQRCode() async {
    try {
      final savePath = await saveToGallery(false);
      if (savePath != null) {
        Share.shareXFiles(
          [XFile(savePath)],
          subject: 'Share QR Code',
          text: 'Hey! Scan my code using this QR Code',
        );
      }
    } catch (err) {
      Get.snackbar(
        'Operation unsuccessful',
        'Unable to share code',
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<Uint8List?> _generateImage() async {
    final boundary = qrCodeKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(
      pixelRatio: Get.context == null ? 1.0 : MediaQuery.of(Get.context!).devicePixelRatio,
    );
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<String?> saveToGallery(bool showDialog) async {
    var status = await Permission.storage.request();

    switch (status) {
      case PermissionStatus.granted:
        isProcessingShare.value = true;
        final imageData = await _generateImage();

        if (imageData != null) {
          final appInfo = await AppInfo.getInfo();

          final result = await ImageGallerySaver.saveImage(
            imageData.buffer.asUint8List(),
            name: "My-${appInfo.appName}-Code-${Guid.newGuid.value})",
          );

          if (result != null) {
            final path = (result['filePath'] as String).replaceFirst('file:///', '');
            if (showDialog) {
              await showAppDialog(
                height: 170,
                title: 'QR Code Saved',
                subtitle: 'Your code was saved to $path',
              );
            }

            return path;
          } else {
            Get.snackbar(
              'Operation unsuccessful',
              'Unable to save image to gallery',
              backgroundColor: dialogInfoBackground,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          isProcessingShare.value = false;
        }
        break;
      case PermissionStatus.denied:
        Get.snackbar(
          'Operation unsuccessful',
          'Please grant storage write access to save image',
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      default:
        await showAppDialog(
          height: 200,
          type: DialogType.neutral,
          title: 'Attention',
          subtitle: 'Storage access is currently denied due to device settings.'
              ' Please navigate to your device settings to grant the necessary permissions'
              ' and ensure that the app has the required access to save and retrieve data',
          actions: [
            DialogButton(
              label: 'GO',
              onTap: openAppSettings,
            ),
            DialogButton(
              label: 'Close',
              onTap: Get.back,
            ),
          ],
        );
        break;
    }

    isProcessingShare.value = false;
    return null;
  }
}
