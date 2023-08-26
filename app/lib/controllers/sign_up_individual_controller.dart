import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/otp.dart';
import '../services/requests/post_requests/rider_registration_request.dart';
import '../shareds/managers/set_session_manager.dart';
import '../shareds/utils/app_colors.dart';
import 'bloc/user_controller.dart';

class SignUpIndividualController extends GetxController {
  final title = Rx<String>('Create individual account');
  final formKey = GlobalKey<FormState>();
  final dialogNavigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bvnController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final isLoaded = false.obs;

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
    // String riderEmail =
    //     '${phoneNumberController.text.trim()}_rider_none@gmail.com';
    String businessName = 'olavent';
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.defaultDialog(
            title: 'Validation', content: const Text('Password mis-matched'));
      } else {
        var response = await userController.riderRegistrationAsync(
            RiderRegistrationRequest(
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                email: emailController.text.trim(),
                phoneNumber: phoneNumberController.text.trim(),
                businessName: businessName,
                bvn: bvnController.text.trim(),
                password: passwordController.text.trim(),
                confirmPassword: confirmPasswordController.text.trim(),
                userAccountType: 'rider',
                ));

        if (response.status) {
          // session.writeRiderEmail(riderEmail);
          Get.to(OtpScreen(phoneNumber: phoneNumberController.text));
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
          isLoaded.value = false;
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
