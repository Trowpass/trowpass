import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../../controllers/forgot_password_otp_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/standard_button.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordOtpScreen extends StatelessWidget {
  final controller = Get.put(ForgotPasswordOtpController());
  final String email;

  // ignore: use_key_in_widget_constructors
  ForgotPasswordOtpScreen({required this.email});

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
                systemOverlayStyle: const SystemUiOverlayStyle(
                  systemNavigationBarColor: Color(0xFFE9E9E9),
                  statusBarColor: offWhite,
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
                          'Please enter the code sent to your email address',
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
                                onChanged: (value) => value.length == 1 ? FocusScope.of(context).nextFocus() : null,
                                decoration: const InputDecoration(
                                  hintText: '*',
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : FocusScope.of(context).previousFocus(),
                                decoration: const InputDecoration(
                                  hintText: '*',
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
                                onChanged: (value) => value.length == 1
                                    ? FocusScope.of(context).nextFocus()
                                    : FocusScope.of(context).previousFocus(),
                                decoration: const InputDecoration(
                                  hintText: '*',
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
                                onChanged: (value) => value.isEmpty ? FocusScope.of(context).previousFocus() : null,
                                decoration: const InputDecoration(
                                  hintText: '*',
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
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Didn\'t receive code?'),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => controller.tryResendOtpSubmit(),
                                child: const Text('Resend'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StandardButton(
                        text: 'Continue',
                        onPressed: () => controller.finishEnterOtp(email),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
