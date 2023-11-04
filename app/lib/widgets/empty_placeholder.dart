import 'package:flutter/widgets.dart';

import '../shareds/utils/images.dart';
import 'app_styles.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String? text;

  const EmptyPlaceholder({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(feelingBlue),
          const SizedBox(height: 24),
          Text(text ?? 'Coming soon', style: appStyles(20, null, FontWeight.bold)),
        ],
      ),
    );
  }
}
