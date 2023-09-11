import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class _FundOptionsBottomSheet extends StatelessWidget {
  final BuildContext context;
  final String bankName, accountNumber;
  final VoidCallback? onCopyTap;
  final VoidCallback? onOtherOptionsTap;
  final bool? autoClose;

  const _FundOptionsBottomSheet(
    this.context, {
    required this.bankName,
    required this.accountNumber,
    this.onCopyTap,
    this.onOtherOptionsTap,
    this.autoClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      height: 420,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 5,
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: grayscale,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Funding Options',
                style: appStyles(16, titleActive, FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Divider(thickness: 2.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Fund your wallet by making a transfer to the bank account below',
              style: appStyles(14, gray, FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: grayscale.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    dense: true,
                    title: Text(
                      'Bank Name',
                      style: appStyles(14, titleActive, FontWeight.bold),
                    ),
                    subtitle: Text(
                      bankName,
                      style: appStyles(14, titleActive, null),
                    ),
                  ),
                  // const Divider(),
                  ListTile(
                    dense: true,
                    title: Text(
                      'Account Number',
                      style: appStyles(14, titleActive, FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          accountNumber,
                          style: appStyles(14, titleActive, null),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: IconButton(
                            iconSize: 16,
                            onPressed: onCopyTap ??
                                () async {
                                  await Clipboard.setData(ClipboardData(text: accountNumber));
                                  Get.snackbar(
                                    'Success',
                                    'Account number copied to clipboard',
                                    colorText: titleActive,
                                    backgroundColor: snackbarColor,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                            icon: const Icon(
                              Icons.copy,
                              color: titleActive,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.info, color: gray),
              title: Text(
                'Your wallet would be automatically funded once payment is received',
                style: appStyles(14, null, null),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                splashColor: primaryColor.withOpacity(0.2),
                onTap: () {
                  onOtherOptionsTap != null ? onOtherOptionsTap!() : null;
                  if (autoClose ?? false) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyLight.withOpacity(0.3)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: greyLight.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        color: primaryColor.withAlpha(150),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_rounded, color: titleActive),
                    title: Text(
                      'Other funding options',
                      style: appStyles(14, titleActive, FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
  bool? autoClose,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) => _FundOptionsBottomSheet(
      context,
      bankName: bankName,
      accountNumber: accountNumber,
      onCopyTap: onCopyTap,
      onOtherOptionsTap: onOtherOptionsTap,
      autoClose: autoClose,
    ),
  );
}
