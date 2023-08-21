import 'package:app/screens/auth/forgot_password/new_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordOtpController extends GetxController {
  TextEditingController codeFourController = TextEditingController();
  TextEditingController codeOneController = TextEditingController();
  TextEditingController codeThreeController = TextEditingController();
  TextEditingController codeTwoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isFocused = false.obs;
  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  void tryResendOtpSubmit() {}

  void finishEnterOtp(String email) {
    var otpOne = codeOneController.text;
    var otpTwo = codeTwoController.text;
    var otpThree = codeThreeController.text;
    var otpFour = codeFourController.text;
    String otpValue = '$otpOne$otpTwo$otpThree$otpFour';
    Get.to(() => NewPasswordScreen(otp: otpValue, email: email));
  }
}
