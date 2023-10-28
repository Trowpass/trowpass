import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/history/history_share_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/app_info.dart';
import '../../shareds/utils/device_info.dart';

class HistoryDetailsController extends GetxController {
  void showShareBottomSheet(BuildContext context) {
    showHistoryShareBottomSheet(context);
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
        colorText: Colors.white,
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
