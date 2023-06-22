import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';
import 'app_styles.dart';

CircularCountDownTimer circleCountdownTimer(
    int duration, CountDownController controller, void Function() onComplete) {
  return CircularCountDownTimer(
    // Countdown duration in Seconds.
    duration: duration,
    initialDuration: 0,
    controller: controller,
    width: 100,
    height: 100,
    ringColor: Colors.grey[300]!,
    ringGradient: null,
    fillColor: primaryColor,
    fillGradient: null,
    backgroundColor: Colors.purple[500],
    backgroundGradient: null,
    strokeWidth: 20.0,
    strokeCap: StrokeCap.round,
    textStyle: appStyles(20, Colors.white, FontWeight.bold),
    textFormat: CountdownTextFormat.MM_SS,
    isReverse: true,
    isReverseAnimation: true,
    isTimerTextShown: true,
    autoStart: true,
    onComplete: onComplete,
    timeFormatterFunction: (defaultFormatterFunction, duration) {
      if (duration.inSeconds == 0) {
        return '0';
      } else {
        // other durations by it's default format
        return Function.apply(defaultFormatterFunction, [duration]);
      }
    },
  );
}
