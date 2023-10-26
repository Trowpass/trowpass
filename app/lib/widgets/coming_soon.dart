import 'package:flutter/widgets.dart';

import '../shareds/utils/images.dart';
import 'app_styles.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(feelingBlue),
          const SizedBox(height: 24),
          Text('Coming soon', style: appStyles(20, null, FontWeight.bold)),
        ],
      ),
    );
  }
}
