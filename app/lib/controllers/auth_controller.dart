import 'package:app/repositories/user_repository.dart';
import 'package:app/screens/auth/account_type_screen.dart';
import 'package:app/screens/auth/otp.dart';
import 'package:app/screens/auth/pin/choose_pin_screen.dart';
import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/services/requests/post_requests/resend_otp_request.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/update_service/update_service.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart' as expiry_timer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart' as resend_timer;

  import '../services/update_service/in_ap_update_service.dart';
  import '../shareds/managers/set_session_manager.dart';
  import '../shareds/utils/app_colors.dart';
  import 'bloc/user_controller.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final resendCountDownController = resend_timer.CountdownController();
  final expiryCountDownController = expiry_timer.CountDownController();
  final isPassword = false.obs;
  final showPassword = false.obs;
  final isFocused = false.obs;
  final isLoaded = false.obs;
  final isExpiryTimeElapsed = false.obs;
  final shouldRememberUser = false.obs;

  UpdateService updateService = UpdateService();

  @override
  void onInit() {
    isLoaded.value = false;
    updateService.checkForInAppUpdate(onUpdateSuccess, onUpdateFailure);
    super.onInit();
  }

    void timerElapsed() {
      isExpiryTimeElapsed.value = true;
    }

  Future<void> login() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await userController.loginAsync(
        UserLoginRequest(
          phoneNumber: emailPhoneNumberController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      if (response.status) {
        if (shouldRememberUser.value) {
          session.writeIsUserLoggedIn(true);
          session.writeShouldRememberMe(true);
          session.writeTokenExpiration(response.data!.tokenExpires);
        }
        
        session.writeUserId(response.data!.userId);
        session.writeAuthorizationToken(response.data!.token);
        if (!response.data!.loginData!.isAccountVerified) {
          String phoneNumber = getSession.readRiderPhoneNumber() ?? '';
          //send new otp
          ResendOtpRequest request = ResendOtpRequest(phoneNumber: phoneNumber);
          var response = await userRepository.resendOtpToPhoneNumberAsync(request);
          if (response.status) {
            isLoaded.value = false;
            isExpiryTimeElapsed.value = false;
            resendCountDownController.restart();
            expiryCountDownController.restart();
          } else {
            Get.defaultDialog(title: 'Information', content: Text(response.message));
            isLoaded.value = false;
          }
          Get.offAll(() => OtpScreen(phoneNumber: phoneNumber));
          isLoaded.value = false;
        } else if (!response.data!.loginData!.isPinCreated) {
          isLoaded.value = false;
          Get.to(() => ChoosePinScreen());
        } else {
          isLoaded.value = false;
          Get.offAll(() => HomeLandingTabScreen());
        }
      } else {
        // Check for invalid credentials specifically
        if (response.responseCode == "11") {
          isLoaded.value = false;
          Get.defaultDialog(
            title: 'Login Failed',
            content: Text(
              response.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else {
          isLoaded.value = false;
          Get.defaultDialog(
            title: 'Information',
            content: Text(
              response.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
          isLoaded.value = false;
    } 
  }

    void createAccount() {
      Get.to(const AccountTypeScreen());
    }

  
void onUpdateSuccess(BuildContext context) {
    Widget alertDialogOkButton = TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK')
    );
      AlertDialog alertDialog = AlertDialog(
        title: const Text("Update Successfully Installed"),
        content: const Text("Trowpass has been updated successfully!"),
        actions: [
          alertDialogOkButton
        ],
      );
      showDialog(context: context,
          builder: (BuildContext context) {
        return alertDialog;
      });
  }

  void onUpdateFailure(String error, BuildContext context) {
    Widget alertDialogTryAgainButton = TextButton(
        onPressed: () {
          updateService.checkForInAppUpdate(onUpdateSuccess, onUpdateFailure);
          Get.back();
        },
        child: const Text("Try Again?")
    );
    Widget alertDialogCancelButton = TextButton(
      onPressed: () => Get.back(),
      child: const Text("Dismiss"),
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Update Failed To Install"),
      content: Text("Trowpass has failed to update because: \n $error"),
      actions: [
        alertDialogTryAgainButton,
        alertDialogCancelButton
      ],
    );
    showDialog(context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}