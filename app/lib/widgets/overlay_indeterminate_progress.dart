import 'dart:ui';

import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';
import 'app_styles.dart';

class OverlayIndeterminateProgress extends StatelessWidget {
  final Widget child;
  final String? loadingMessage;
  final Color? progressColor, overlayBackgroundColor;
  final bool isLoading;

  const OverlayIndeterminateProgress({
    super.key,
    required this.child,
    this.loadingMessage,
    required this.progressColor,
    required this.isLoading,
    required this.overlayBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isLoading,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Opacity(
              opacity: 0.3,
              child: ModalBarrier(
                dismissible: false,
                color: overlayBackgroundColor?.withOpacity(0.3) ?? overlayColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: LinearProgressIndicator(
                      backgroundColor: (progressColor ?? primaryColor).withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor ?? primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  loadingMessage ?? 'Loading',
                  style: appStyles(16, null, null),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
