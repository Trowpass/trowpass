// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_styles.dart';

/// Modal types
enum DialogType { error, success, warning }

class _AppDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final DialogType type;
  final double height;

  const _AppDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async => true,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: height,
          decoration: BoxDecoration(
            color: type == DialogType.success
                ? dialogSuccessBackground
                : type == DialogType.error
                    ? dialogErrorBackground
                    : dialogWarningBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: type == DialogType.success
                  ? dialogSuccessBorder
                  : type == DialogType.error
                      ? dialogErrorBorder
                      : dialogWarningBorder,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      size: 24,
                      Icons.info_outline,
                      color: type == DialogType.success
                          ? dialogSuccessBorder
                          : type == DialogType.error
                              ? dialogErrorBorder
                              : dialogWarningBorder,
                    ),
                  ),
                  Text(
                    title,
                    style: appStyles(16, Colors.black, FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                subtitle,
                style: appStyles(14, Colors.black, null),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> showAppDialog<T>({
  double height = 150,
  required String title,
  required String subtitle,
  DialogType type = DialogType.success,
}) {
  return Get.dialog(
    _AppDialog(
      height: height,
      title: title,
      subtitle: subtitle,
      type: type,
    ),
    transitionCurve: Curves.easeInOut,
  );
}
