import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/fund_options_bottom_sheet.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        title: const Text('Test Screen'),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: Center(
        child: StandardButton(
          text: 'Test',
          onPressed: () {
            showFundOptionsBottomSheet(
              context,
              bankName: 'Access Bank',
              accountNumber: '0092873385',
              onOtherOptionsTap: () {},
            );
          },
        ),
      ),
    );
  }
}
