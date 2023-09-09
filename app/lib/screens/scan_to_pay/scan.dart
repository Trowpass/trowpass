// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:app/controllers/scan_to_pay_controllers/scan_controller.dart';
import 'package:app/screens/scan_to_pay/pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../shareds/utils/app_colors.dart';

class QrScanArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrScanAreaState();
}

class _QrScanAreaState extends State<QrScanArea> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final qrScanController = Get.put(QrScanController());

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarBrightness: Brightness.light, // For iOS
            statusBarIconBrightness: Brightness.light, // For Android
            systemNavigationBarColor: navigationBarBackground,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                buildQrView(context),
                Positioned(
                  bottom: 10,
                  child: buildResult(),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildResult() => Text(
        result != null ? 'Result : ${result!.code}' : 'scan the code',
        maxLines: 3,
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderWidth: 5,
          borderRadius: 10,
          borderLength: 50,
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
        ),
      );

  // void onQRViewCreated(QRViewController controller) {
  //   setState(() => this.controller = controller);

  //   controller.scannedDataStream
  //       .listen((result) => setState(() => this.result = result));
  //   print(result);
  //   if (result != null) {
  //   } else {
  //     Get.to(PayScreen(result.code));
  //   }
  // }
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((result) {
      setState(() {
        this.result = result;
        qrScanController
            .setResult(result); // Update the result in the controller

        if (result != null) {
          Get.to(PayScreen(result.code));
        }
      });
    });
  }
}
