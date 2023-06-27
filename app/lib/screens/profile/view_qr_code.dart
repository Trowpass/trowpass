import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/view_user_qr_code_controller.dart';
import '../../widgets/app_styles.dart';

class ViewQRCodeScreen extends StatelessWidget {
  ViewQRCodeScreen({super.key});
  final controller = Get.put(ViewUserQRCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Image.network(controller.qrCode.value),
          ),
          Row(
            children: [
              Expanded(
                  child: TextButton.icon(
                icon: const Icon(
                  Icons.share_rounded,
                  color: titleActive,
                ),
                label: Text('Share My Code',
                    style: appStyles(16, titleActive, FontWeight.w500)),
                onPressed: null,
              )),
              Expanded(
                  child: TextButton.icon(
                icon: const Icon(
                  Icons.download_rounded,
                  color: titleActive,
                ),
                label: Text('Save to Gallery',
                    style: appStyles(16, titleActive, FontWeight.w500)),
                onPressed: null,
              ))
            ],
          )
        ]),
      ),
    );
  }
}
