import 'package:app/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/otp.dart';
import '../services/requests/post_requests/rider_registration_request.dart';
import '../shareds/managers/set_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import '../widgets/password_strength_bar.dart';
import 'bloc/user_controller.dart';

class SignUpIndividualController extends GetxController {
  final title = Rx<String>('Create individual account');
  final formKey = GlobalKey<FormState>();
  final dialogNavigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController bvnController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final password = ''.obs;
  final strength = Rx(Strength.weak);

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final isLoaded = false.obs;
  final isPasswordHidden = true.obs;
  final isComfirmPasswordHidden = true.obs;
  final isFocused = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  Future<void> registerRider() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    String businessName = 'N/A';
    String bvn = 'N/A';

    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.defaultDialog(title: 'Validation', content: const Text('Password mis-matched'));
        isLoaded.value = false;
      } else {
        var response = await userController.riderRegistrationAsync(RiderRegistrationRequest(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          businessName: businessName,
          bvn: bvn,
          phoneNumber: phoneNumberController.text.trim(),
          password: passwordController.text.trim(),
          confirmPassword: confirmPasswordController.text.trim(),
          userAccountType: 'rider',
        ));
        if (response.status) {
          session.writeRiderPhoneNumber(phoneNumberController.text);
          Get.offAll(() => OtpScreen(phoneNumber: phoneNumberController.text));
          isLoaded.value = false;
        } else {
          Get.defaultDialog(title: 'Information', content: Text(response.message));
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

  void proceedRegister() {
    final isValidated = formKey.currentState!.validate();
    var isPasswordSecure = strength.value == Strength.secure;

    if (isValidated) {
      if (isPasswordSecure) {
        formKey.currentState!.save();
        registerRider();
      } else {
        var title = 'Password not secure';
        var subtitle = 'Password should be at least 8 characters long and include a mix of'
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
}
