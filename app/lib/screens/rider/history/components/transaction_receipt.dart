import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../services/responses/transaction_history/payment_type.dart';
import '../../../services/responses/transaction_history/transaction_history_response.dart';

class TransactionReceipt extends StatelessWidget {
  final TransactionHistoryData history;
  const TransactionReceipt({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 32),
            _buildDetailRow('Date & Time', history.formattedDateTime),
            const SizedBox(height: 22),
            _buildDetailRow('Transaction Type', history.paymentType == PaymentType.payIn ? 'Deposit' : 'Withdrawal'),
            const SizedBox(height: 22),
            _buildDetailRow('Amount', history.displayAmount),
            const SizedBox(height: 22),
            _buildDetailRow('Fee', history.displayFee),
            const SizedBox(height: 22),
            _buildDetailRow('Payment Method', history.paymentMethod.toString()),
            const SizedBox(height: 22),
            _buildDetailRow('Reference Code', history.reference),
            const SizedBox(height: 22),
            _buildDetailRow('Status', history.status.toCapitalized(), dataTextColor: Colors.green),
            const SizedBox(height: 22),
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
