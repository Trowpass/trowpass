// import 'package:app/controllers/bloc/user_controller.dart';
// import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
// import 'package:app/services/requests/post_requests/kyc_registration_request.dart';
// import 'package:app/shareds/managers/set_session_manager.dart';
// import 'package:app/shareds/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class KycRegistrationController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController bvnController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   final isLoaded = false.obs;

//   @override
//   void onInit() {
//     isLoaded.value = false;
//     super.onInit();
//   }
//   SetSessionManager session = SetSessionManager();
//   UserController userController = UserController();
//   DateTime? selectedDOB;
  
//  Future<void> submitKyc() async {
//     isLoaded.value = true;
//     Get.focusScope!.unfocus();
//      try {
//         var response = await userController.kycRegistrationAsync(
//             KYCRegistrationRequest(
//                 bvn: bvnController.text.trim(),
//                 address: addressController.text.trim(),
//                 dateOfBirth: selectedDOB ?? DateTime.now(),
//                 ));

//         if (response.status) {
//         Get.to(HomeLandingTabScreen());
//         } else {
//           Get.defaultDialog(
//               title: 'Information', content: Text(response.message));
//           isLoaded.value = false;
//         }
//     } catch (e, stackTrace) {
//       print('Error: $e');
//       print('Stack Trace: $stackTrace');
//       Get.snackbar('Information', e.toString(),
//           backgroundColor: validationErrorColor,
//           snackPosition: SnackPosition.BOTTOM);
//       isLoaded.value = false;
//     }
//   }


// }
