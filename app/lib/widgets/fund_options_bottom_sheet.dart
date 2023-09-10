import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';

class _FundOptionsBottomSheet extends StatelessWidget {
  final BuildContext context;
  final String bankName, accountNumber;
  final VoidCallback? onCopyTap;
  final VoidCallback? onOtherOptionsTap;

  const _FundOptionsBottomSheet(
    this.context, {
    required this.bankName,
    required this.accountNumber,
    this.onCopyTap,
    this.onOtherOptionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      height: 200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: gray,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// show fund options dialog
Future<T?> showFundOptionsBottomSheet<T>(
  BuildContext context, {
  required String bankName,
  required String accountNumber,
  VoidCallback? onCopyTap,
  VoidCallback? onOtherOptionsTap,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) => _FundOptionsBottomSheet(
      context,
      bankName: bankName,
      accountNumber: accountNumber,
      onCopyTap: onCopyTap,
      onOtherOptionsTap: onOtherOptionsTap,
    ),
  );
}
