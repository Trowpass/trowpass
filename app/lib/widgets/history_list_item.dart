import 'package:app/services/responses/transaction_history/payment_type.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:flutter/material.dart';

import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/border_radius.dart';
import '../../widgets/app_styles.dart';

class HistoryListItem extends StatefulWidget {
  final TransactionHistoryData history;

  const HistoryListItem(this.history, {super.key});

  @override
  State<StatefulWidget> createState() {
    return HistoryListItemState();
  }
}

class HistoryListItemState extends State<HistoryListItem> {
  @override
  Widget build(BuildContext context) {
    var transactionType = widget.history.paymentType;
    var color = transactionType == PaymentType.payIn ? successColor : validationErrorColor;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
            border: Border.all(color: greyLight, width: 0.3),
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
                      widget.history.createdBy,
                      style: appStyles(14, titleActive, FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.history.formattedDate,
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
                      widget.history.displayAmount,
                      style: appStyles(14, color, FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
