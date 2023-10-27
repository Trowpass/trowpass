import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/services/responses/transaction_history/payment_type.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/app_styles.dart';

class TransactionHistoryDetailsScreen extends StatelessWidget {
  final TransactionHistoryData history;

  const TransactionHistoryDetailsScreen({super.key, required this.history});

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
              child: _buildReceipt(),
            ),
            Expanded(
              flex: 2,
              child: _buildActions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        StandardButton(
          onPressed: () {
            // show share bottom sheet
          },
          text: 'Share Receipt',
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          onTap: () {
            // send email to sanwopay@gmail.com
          },
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

  Widget _buildReceipt() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              history.paymentType == PaymentType.payIn ? 'TOP-UP' : 'WITHDRAWAL',
              style: appStyles(16, Colors.black, null),
            ),
            const SizedBox(height: 8),
            Text(
              history.displayAmount,
              style: appStyles(22, Colors.black, FontWeight.bold),
            ),
            const SizedBox(height: 48),
            _buildDetailRow('Date & Time', history.formattedDateTime),
            const SizedBox(height: 32),
            _buildDetailRow('Transaction Type', history.paymentType == PaymentType.payIn ? 'Deposit' : 'Withdrawal'),
            const SizedBox(height: 32),
            _buildDetailRow('Amount', history.displayAmount),
            const SizedBox(height: 32),
            _buildDetailRow('Fee', history.displayFee),
            const SizedBox(height: 32),
            _buildDetailRow('Payment Method', history.paymentMethod.toString()),
            const SizedBox(height: 32),
            _buildDetailRow('Reference Code', history.reference),
            const SizedBox(height: 32),
            _buildDetailRow('Status', history.status.toCapitalized(), dataTextColor: Colors.green),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String reason,
    String data, {
    Color? reasonTextColor,
    Color? dataTextColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reason,
          style: appStyles(16, reasonTextColor ?? Colors.black, null),
        ),
        Text(
          data,
          style: appStyles(16, dataTextColor ?? Colors.black, null),
        ),
      ],
    );
  }
}
