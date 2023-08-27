import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../controllers/otp_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/circle_countdown_timer.dart';
import '../../widgets/standard_button.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen({super.key, required this.phoneNumber});
  final controller = Get.put(OtpController());

// to prevent back button click
  Future<bool> _onWillPop() async => false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWithAppIcon(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          circularProgressColor: primaryColor,
          appIcon: appLogo(70, 70),
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: primaryColor,
                  systemNavigationBarColor: primaryColor,
                  statusBarIconBrightness: Brightness.light, // For Android
                  statusBarBrightness: Brightness.light, // For iOS
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
                elevation: 0,
                title: Text(
                  controller.title.value,
                  style: appStyles(18, titleActive, FontWeight.w500),
                ),
                backgroundColor: background,
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 8, bottom: 16),
                      child: Text(
                        'Please enter the code sent to $phoneNumber. It expires in 5 minutes',
                        style: appStyles(16, null, null),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: controller.formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeOneController,
                                validator: (value) =>
                                    value != null && value.isEmpty ? "" : null,
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                  hintText: '*',
                                  errorStyle: const TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
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
                                decoration: InputDecoration(
                                  hintText: '*',
                                  errorStyle: const TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
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
                                decoration: InputDecoration(
                                  hintText: '*',
                                  errorStyle: const TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                controller: controller.codeFourController,
                                validator: (value) =>
                                    value != null && value.isEmpty ? "" : null,
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                  hintText: '*',
                                  errorStyle: const TextStyle(height: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
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
                              controller: controller.resendCountDownController,
                              seconds: controller.countdown,
                              build: (_, double time) {
                                Duration duration =
                                    Duration(seconds: time.toInt());
                                int minutes = duration.inMinutes;
                                int seconds = duration.inSeconds.remainder(60);
                                String formattedTime =
                                    "${"$minutes".padLeft(2, "0")}:${"$seconds".padLeft(2, '0')}";

                                return TextButton(
                                  onPressed: () {
                                    if ([controller.countdown, 0]
                                        .contains(time)) {
                                      controller
                                          .tryResendOtpSubmit(phoneNumber);
                                    }
                                  },
                                  child: Text(
                                    [controller.countdown, 0].contains(time)
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
                      padding: const EdgeInsets.all(30),
                      child: Obx(() => StandardButton(
                          text: 'VERIFY AND LOGIN',
                          onPressed: controller.isExpiryTimeElapsed.value
                              ? null
                              : () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.formKey.currentState!.save();
                                    controller.verifyOtp();
                                  }
                                })),
                    ),
                    circleCountdownTimer(
                      controller.countDownControllerDuration,
                      controller.expiryCountDownController,
                      controller.timerElapsed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
