import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/shareds/constants/file_upload_purpose.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/auth/login.dart';
import '../services/responses/file_upload_response.dart';
import '../shareds/constants/key_constants.dart';
import '../shareds/managers/set_session_manager.dart';

class UserProfileController extends GetxController {
  final title = Rx<String>('Profile');
  final fullName = Rx<String>('');
  final isLoading = false.obs;

  GetSessionManager session = GetSessionManager();
  SetSessionManager session2 = SetSessionManager();
  final userController = UserController();
  final profileImage = Rx<String>('');
  final kycRegistrationText = ''.obs;

  @override
  void onInit() {
    displayAccountType();
    getUserProfile();
    super.onInit();
  }

  void displayAccountType() {
    String accountType = session.readAccountType();
    switch (accountType) {
      case t1Account:
        kycRegistrationText.value = 'Upgrade Account to T2';
        break;
      case t2Account:
        kycRegistrationText.value = 'Upgrade Account to T3';
        break;
      case t3Account:
        kycRegistrationText.value = '';
        break;
      default:
        kycRegistrationText.value = 'Upgrade Account to T1';
    }
  }

  Future getUserProfile() async {
    try {
      isLoading.value = true;
      final response = await userController.userProfileAsync();
      if (response.status && response.data != null) {
        final data = response.data!;
        session2.writeAccountType(data.accountType);
        displayAccountType();
        profileImage.value = data.profilePix!;
        fullName.value =
            '${data.firstName.capitalize} ${data.lastName.capitalize}';
        isLoading.value = false;
        return response;
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    }
  }

  Future<void> uploadImage() async {
    final isAlreadyShown = session.readProfilePictureInfoShown();
    if (!isAlreadyShown) await showInfoPopup();

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    try {
      if (image != null) {
        isLoading.value = true;
        FileUploadResponse response = await userController.uploadFileAsync(
          purpose: FileUploadPurpose.profilePicture,
          filepath: image.path,
        );
        if (response.status) {
          await getUserProfile();
          Get.snackbar(
            'Success',
            'Profile picture uploaded',
            backgroundColor: dialogInfoBackground,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          isLoading.value = false;
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
      isLoading.value = false;
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> showInfoPopup() async {
    return await Get.dialog(
      AlertDialog(
        title: const Text('Attention'),
        content: const Text(
          'Please make sure to upload a square image of about 150 x 150 pixels,'
          ' as the image will be cropped to fit this size.',
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {
              session2.setIsProfilePictureInfoShown(true);
              Get.back(result: true);
            },
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void logout() {
    session2.logoutUser();
    isRemember();
    Get.offAll(() => LoginScreen());
  }

  void isRemember() {
    var remember = session.readShouldRememberMe();
    if (!remember) {
      session2.writeIsUserLoggedIn(false);
      session2.writeTokenExpiration(null);
      session2.writeShouldRememberMe(false);
    }
  }
}