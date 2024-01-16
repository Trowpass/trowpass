import 'package:flutter/material.dart';

import '../../../shareds/utils/images.dart';
import '../../../widgets/app_styles.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(feelingBlue),
          const SizedBox(height: 24),
          Text('No transaction history', style: appStyles(20, null, FontWeight.bold)),
        ],
      ),
    );
  }
}
