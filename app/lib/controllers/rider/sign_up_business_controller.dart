import 'package:app/controllers/rider/bloc/user_controller.dart';
import 'package:app/screens/auth/otp.dart';
import 'package:app/services/requests/rider/post_requests/rider_registration_request.dart';
import 'package:app/shareds/enums/user_type.dart';
import 'package:app/shareds/managers/rider/set_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/password_strength_bar.dart';

class SignUpBusinessController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final password = ''.obs;
  final strength = Rx(Strength.weak);

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final isLoaded = false.obs;
  final isPasswordHidden = true.obs;
  final isFocused = false.obs;

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  final TextEditingController bvnController = TextEditingController();

  void trySubmit() {
    Get.focusScope!.unfocus();
    final isValidated = formKey.currentState!.validate();
    var isPasswordSecure = strength.value == Strength.secure;
    if (isValidated) {
      if (isPasswordSecure) {
        formKey.currentState!.save();
        registerFleetManager();
      } else {
        var title = 'Password not secure';
        var subtitle =
            'Password should be at least 8 characters long and include a mix of'
            ' uppercase and lowercase letters, numbers,'
            ' and special characters (such as !, @, #, \$, etc.) for added security';
        showAppDialog(
          type: DialogType.warning,
          title: title,
          subtitle: subtitle,
        );
      }
    }
  }

  Future<void> registerFleetManager() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    String userType = 'fleet_manager';

    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.defaultDialog(
            title: 'Validation', content: const Text('Password mis-matched'));
        isLoaded.value = false;
      } else if (!EmailValidator.validate(emailController.text)) {
        Get.defaultDialog(
            title: 'Validation', content: const Text('Invalid email address'));
        isLoaded.value = false;
      } else {
        var response = await userController
            .riderRegistrationAsync(RiderRegistrationRequest(
          firstName: 'N/A',
          lastName: 'N/A',
          email: emailController.text.trim(),
          businessName: businessNameController.text.trim(),
          phoneNumber: 'N/A',
          password: passwordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
          userAccountType: userType,
        ));
        if (response.status) {
          session.writeEmail(emailController.text.trim());
          session.writeUserType(UserType.fleetManager);
          Get.offAll(() => OtpScreen(verificationParam: emailController.text));
          isLoaded.value = false;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
          isLoaded.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  void checkPassword(String value) {
    password.value = value.trim();
    if (password.isEmpty) {
      strength.value = Strength.weak;
    } else if (password.value.length < 8) {
      strength.value = Strength.weak;
    } else {
      if (!regex.hasMatch(password.value)) {
        strength.value = Strength.moderate;
      } else {
        strength.value = Strength.secure;
      }
    }
  }
}
