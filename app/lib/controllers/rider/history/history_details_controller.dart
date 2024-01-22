import 'dart:io';
import 'dart:ui';

import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/widgets/app_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shareds/utils/app_colors.dart';
import '../../../shareds/utils/app_info.dart';
import '../../../shareds/utils/device_info.dart';

class HistoryDetailsController extends GetxController {
  final isProcessing = false.obs;
  final key = GlobalKey();
  final toPDFframeId = 'pdf-export';
  ExportDelegate exportDelegate = ExportDelegate();

  Future<Uint8List?> _generateImage() async {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(
      pixelRatio: Get.context == null ? 1.0 : MediaQuery.of(Get.context!).devicePixelRatio,
    );
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<String?> _saveHistoryImageToGallery() async {
    final deviceInfo = await DeviceInfo.getInfo();
    PermissionStatus status;

    if ((deviceInfo?.sdkInt ?? 0) >= 33) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        isProcessing.value = true;
        final imageData = await _generateImage();
        if (imageData != null) {
          final result = await ImageGallerySaver.saveImage(
            imageData.buffer.asUint8List(),
            name: 'Transaction-history-${Guid.newGuid.value})',
          );
          isProcessing.value = false;
          return (result['filePath'] as String).replaceFirst('file:///', '');
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

    isProcessing.value = false;
    return null;
  }

  Future<String?> _saveHistoryPDFToGallery() async {
    final deviceInfo = await DeviceInfo.getInfo();
    PermissionStatus status;

    if ((deviceInfo?.sdkInt ?? 0) >= 33) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        isProcessing.value = true;
        try {
          Directory? dir;
          final pdfData = await _generatePDFDocument();

          if (defaultTargetPlatform == TargetPlatform.android) {
            dir = await getExternalStorageDirectory();
            if (dir == null) return null;
          } else {
            dir = await getApplicationDocumentsDirectory();
          }

          final File file = File('${dir.path}/Transaction-history-${Guid.newGuid.value}.pdf');
          final savedFile = await file.writeAsBytes(pdfData);
          isProcessing.value = false;
          return savedFile.path.replaceFirst('file:///', '');
        } catch (_) {
          return null;
        }
      case PermissionStatus.denied:
        Get.snackbar(
          'Operation unsuccessful',
          'Please grant storage write access to save pdf',
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

    isProcessing.value = false;
    return null;
  }

  Future<void> saveHistoryAsImage() async {
    final savePath = await _saveHistoryImageToGallery();
    if (savePath != null) {
      await showAppDialog(
        height: 180,
        type: DialogType.neutral,
        title: 'Success',
        subtitle: 'Transaction history was saved as image to your device\'s gallery',
        actions: [
          DialogButton(
            label: 'Close',
            onTap: Get.back,
          ),
          DialogButton(
            label: 'Share',
            onTap: () {
              Share.shareXFiles([XFile(savePath)], text: 'Share Receipt as Image');
            },
          ),
        ],
      );
    } else {
      Get.snackbar(
        'Error',
        'Unable to save generated image to gallery',
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveHistoryAsPDF() async {
    final savePath = await _saveHistoryPDFToGallery();
    if (savePath != null) {
      await showAppDialog(
        height: 180,
        type: DialogType.neutral,
        title: 'Success',
        subtitle: 'Transaction history was saved as PDF to your device\'s gallery',
        actions: [
          DialogButton(
            label: 'Close',
            onTap: Get.back,
          ),
          DialogButton(
            label: 'Share',
            onTap: () {
              Share.shareXFiles([XFile(savePath)], text: 'Share Receipt as PDF');
            },
          ),
        ],
      );
    } else {
      Get.snackbar(
        'Error',
        'Unable to save generated pdf to gallery',
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<Uint8List> _generatePDFDocument() async {
    final ExportOptions overrideOptions = ExportOptions(
      textFieldOptions: TextFieldOptions.uniform(
        interactive: false,
      ),
      checkboxOptions: CheckboxOptions.uniform(
        interactive: false,
      ),
    );
    var document = await exportDelegate.exportToPdfDocument(
      toPDFframeId,
      overrideOptions: overrideOptions,
    );
    return await document.save();
  }

  void reportToSupportMail() async {
    const supportMail = 'info@sanwopay.com';
    final deviceInfo = await DeviceInfo.getInfo();
    final appInfo = await AppInfo.getInfo();

    final String subjectOfMail = 'Report Bug In ${appInfo.appName.toCapitalized()} app';
    final String bodyOfMail = 'Dear ${appInfo.appName.toCapitalized()} Support Team,'
        '%0A%0A%0A%0A'
        'Device Info:'
        '%0A%0A'
        'Device Name: ${deviceInfo?.deviceName}'
        '%0A'
        'Model: ${deviceInfo?.model}'
        '%0A'
        'Brand: ${deviceInfo?.brand}'
        '%0A'
        'OS version: ${deviceInfo?.osVersion}';

    final Uri reportIssueUrl = Uri.parse('mailto:$supportMail?subject=$subjectOfMail&body=$bodyOfMail');
    if (!await launchUrl(reportIssueUrl)) {
      Get.snackbar(
        'Uh-oh!',
        'Operation was incomplete, try again',
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
