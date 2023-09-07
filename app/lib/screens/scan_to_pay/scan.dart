// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../shareds/utils/app_colors.dart';

class QrScanArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrScanAreaState();
}

class _QrScanAreaState extends State<QrScanArea> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

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
              ],
            ),
          ),
        ),
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

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
  }
}
