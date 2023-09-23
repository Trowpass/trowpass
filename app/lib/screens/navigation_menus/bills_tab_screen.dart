import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../../shareds/utils/app_colors.dart';

class BillsTabScreen extends StatelessWidget {
  const BillsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Biils Payment',
              style: appStyles(22, Colors.red, FontWeight.w500),
            ),
            Image.asset(comingSoon)
          ],
        ),
      ),
    );
  }
}
