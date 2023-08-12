import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  appLogo(200, 200),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        controller.title.value,
                        textScaleFactor: 1.5,
                      ),
                      subtitle: Text(
                        'Please enter the code sent to $phoneNumber. It expires in 5 minutes',
                        style: appStyles(16, null, null),
                      ),
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : null,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
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
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(child: Text('Didn\'t receive code?')),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              controller.countDownController.start();
                              controller.isTimeElapsed.value = false;
                              controller.tryResendOtpSubmit();
                            },
                            child: const Text('Resend'),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Obx(() => StandardButton(
                        text: 'VERIFY AND LOGIN',
                        onPressed: controller.isTimeElapsed.value
                            ? null
                            : () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.verifyOtp();
                                }
                              })),
                  ),
                  circleCountdownTimer(controller.countDownControllerDuration,
                      controller.countDownController, timerElapsed),
                ],
              ),
            ),
          ),
        )));
  }

  void timerElapsed() {
    controller.isTimeElapsed.value = true;
  }
}
