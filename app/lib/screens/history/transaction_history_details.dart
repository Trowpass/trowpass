import 'package:app/screens/history/history_share_bottom_sheet.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/screens/history/components/transaction_receipt.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/history/history_details_controller.dart';
import '../../widgets/app_styles.dart';
import 'history_share_image_preview.dart';
import 'history_share_pdf_preview.dart';

class TransactionHistoryDetailsScreen extends StatelessWidget {
  final TransactionHistoryData history;
  final controller = Get.put(HistoryDetailsController());

  TransactionHistoryDetailsScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Transaction Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: TransactionReceipt(history: history),
            ),
            Expanded(
              flex: 2,
              child: _buildActions(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        StandardButton(
          onPressed: () {
            showHistoryShareBottomSheet(
              context,
              onSaveAsImage: () => Get.to(() => HistoryShareImagePreview(history: history)),
              onSaveAsPDF: () => Get.to(() => HistorySharePDFPreview(history: history)),
            );
          },
          text: 'Share Receipt',
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          onTap: () => controller.reportToSupportMail(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Report a problem',
              style: appStyles(14, Colors.red, null),
            ),
          ),
        )
      ],
    );
  }
}
