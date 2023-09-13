import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../screens/payments/payment_method.dart';

// ignore: use_key_in_widget_constructors
class WidgetTest extends StatefulWidget {
  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        title: Text(
          'Test Screen',
          style: appStyles(16, titleActive, null),
        ),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: StandardButton(
            text: 'Test',
            onPressed: () {
              Get.to(() => PaymentMethodScreen(), fullscreenDialog: true, arguments: {'amount': 500.00});
            },
          ),
        ),
      ),
    );
  }
}
