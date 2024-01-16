import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/rider/history/history_details_controller.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/app_styles.dart';
import 'components/transaction_receipt.dart';

class HistoryShareImagePreview extends StatelessWidget {
  final TransactionHistoryData history;
  final controller = Get.put(HistoryDetailsController());

  HistoryShareImagePreview({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.key,
      child: Scaffold(
        backgroundColor: background,
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
          title: Text(
            'Transaction Receipt',
            style: appStyles(18, titleActive, FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  activityLogo(50, 50),
                  const SizedBox(height: 16),
                  TransactionReceipt(
                    history: history,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Generated on: ${DateFormat('y-MM-dd, HH:mm:ss').format(DateTime.now())}'),
            const SizedBox(height: 16),
            StandardButton(
              text: 'Save as Image',
              onPressed: controller.saveHistoryAsImage,
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
