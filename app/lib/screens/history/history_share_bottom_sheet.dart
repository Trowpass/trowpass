import 'package:flutter/material.dart';

import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/transparent_button.dart';

class _HistoryShareBottomSheet extends StatelessWidget {
  final bool? autoClose;

  const _HistoryShareBottomSheet(
    BuildContext context, {
    this.autoClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      height: 230,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: grayscale,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share Transaction Receipt',
            style: appStyles(18, null, null),
          ),
          const SizedBox(height: 16),
          TransparentButton(
            contentAlignment: MainAxisAlignment.start,
            text: 'Save as Image',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          TransparentButton(
            contentAlignment: MainAxisAlignment.start,
            text: 'Save as PDF',
            onTap: () {},
          )
        ],
      ),
    );
  }
}

/// show share transaction receipt bottom sheet
Future<T?> showHistoryShareBottomSheet<T>(
  BuildContext context, {
  bool? autoClose,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) => _HistoryShareBottomSheet(
      context,
      autoClose: autoClose,
    ),
  );
}
