import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../controllers/rider/forgot_password_otp_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/circle_countdown_timer.dart';
import '../../../widgets/overlay_indeterminate_progress.dart';
import '../../../widgets/standard_button.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordOtpScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  ForgotPasswordOtpScreen({required this.email});

  final controller = Get.put(ForgotPasswordOtpController());
  final String email;

// to prevent back button click
  Future<bool> _onWillPop() async => false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return OverlayIndeterminateProgress(
        isLoading: controller.isLoaded.value,
        overlayBackgroundColor: background,
        progressColor: primaryColor,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: background,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: primaryColor,
                statusBarBrightness: Brightness.light, // For iOS
                statusBarIconBrightness: Brightness.light, // For Android
                systemNavigationBarColor: navigationBarBackground,
                systemNavigationBarIconBrightness: Brightness.light,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
              elevation: 0,
              title: Text(
                'Enter OTP',
                style: appStyles(18, titleActive, FontWeight.w500),
              ),
              backgroundColor: background,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        'Please enter the code sent to $email. It expires in 2 minutes',
                        style: appStyles(16, null, null),
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextFormField(
                              controller: controller.codeOneController,
                              onChanged: (value) => value.length == 1
                                  ? FocusScope.of(context).nextFocus()
                                  : null,
                              validator: (value) =>
                                  value != null && value.isEmpty ? "" : null,
                              decoration: const InputDecoration(
                                hintText: '*',
                                errorStyle: TextStyle(height: 0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3.0),
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineMedium,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextFormField(
                              controller: controller.codeTwoController,
                              validator: (value) =>
                                  value != null && value.isEmpty ? "" : null,
                              onChanged: (value) => value.length == 1
                                  ? FocusScope.of(context).nextFocus()
                                  : FocusScope.of(context).previousFocus(),
                              decoration: const InputDecoration(
                                hintText: '*',
                                errorStyle: TextStyle(height: 0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3.0),
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineMedium,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextFormField(
                              controller: controller.codeThreeController,
                              validator: (value) =>
                                  value != null && value.isEmpty ? "" : null,
                              onChanged: (value) => value.length == 1
                                  ? FocusScope.of(context).nextFocus()
                                  : FocusScope.of(context).previousFocus(),
                              decoration: const InputDecoration(
                                hintText: '*',
                                errorStyle: TextStyle(height: 0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3.0),
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineMedium,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextFormField(
                              controller: controller.codeFourController,
                              onChanged: (value) => value.isEmpty
                                  ? FocusScope.of(context).previousFocus()
                                  : null,
                              validator: (value) =>
                                  value != null && value.isEmpty ? "" : null,
                              decoration: const InputDecoration(
                                hintText: '*',
                                errorStyle: TextStyle(height: 0),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3.0),
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineMedium,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Didn\'t receive code?'),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Countdown(
                              controller: controller.countDownController,
                              seconds: controller.resendCountdownDuration,
                              build: (_, double time) {
                                Duration duration =
                                    Duration(seconds: time.toInt());
                                int minutes = duration.inMinutes;
                                int seconds = duration.inSeconds.remainder(60);
                                String formattedTime =
                                    "${"$minutes".padLeft(2, "0")}:${"$seconds".padLeft(2, '0')}";

                                return TextButton(
                                  onPressed: () => [
                                    controller.resendCountdownDuration,
                                    0
                                  ].contains(time)
                                      ? controller.tryResendOtpSubmit(email)
                                      : null,
                                  child: Text(
                                    [controller.resendCountdownDuration, 0]
                                            .contains(time)
                                        ? 'Resend'
                                        : 'Resend in $formattedTime',
                                  ),
                                );
                              },
                              interval: const Duration(milliseconds: 1000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Obx(() => StandardButton(
                            text: 'Continue',
                            onPressed: controller.isExpiryTimeElapsed.value
                                ? null
                                : () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.formKey.currentState!.save();
                                      controller.finishEnterOtp(email);
                                    }
                                  },
                          )),
                    ),
                    circleCountdownTimer(
                      controller.expiryCountDownDuration,
                      controller.expiryCountDownController,
                      controller.timerElapsed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
