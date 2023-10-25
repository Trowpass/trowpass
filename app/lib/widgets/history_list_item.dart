import 'package:app/services/responses/transaction_history/payment_type.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/border_radius.dart';
import '../../widgets/app_styles.dart';
import '../screens/history/transaction_history_details.dart';

class HistoryListItem extends StatelessWidget {
  final TransactionHistoryData transactHistory;

  const HistoryListItem(this.transactHistory, {super.key});

  @override
  Widget build(BuildContext context) {
    var transactionType = transactHistory.paymentType;
    var color = transactionType == PaymentType.payIn ? successColor : validationErrorColor;

    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            onTap: () => Get.to(
              () => TransactionHistoryDetailsScreen(history: transactHistory),
              transition: Transition.downToUp,
            ),
            child: Ink(
              width: double.infinity,
              decoration: BoxDecoration(
                color: background,
                border: Border.all(color: border, width: 0.3),
                borderRadius: BorderRadius.circular(cardBorderRadius),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: <Widget>[
                  _buildIndicator(transactionType),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactHistory.status.toUpperCase(),
                          style: appStyles(14, titleActive, FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          transactHistory.formattedDate,
                          style: appStyles(12, gray, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          transactHistory.displayAmountWithPS,
                          style: appStyles(14, color, FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildIndicator(PaymentType transactionType) {
    const iconSize = 24.0;
    final color = transactionType == PaymentType.payIn ? successColor : validationErrorColor;

    final icon = transactionType == PaymentType.payIn
        ? Icon(
            Icons.add,
            size: iconSize,
            color: color,
          )
        : Icon(
            Icons.close,
            size: iconSize,
            color: color,
          );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2000),
      ),
      child: icon,
    );
  }
}
