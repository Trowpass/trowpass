import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';

class UserProfileController extends GetxController {
  final title = Rx<String>('Profile');
  final fullName = Rx<String>('');
  final fileName = Rx<String?>('');
  final profilePhoto = Rx<String>('');
  final profilePlaceHolder = ''.obs;

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();
  @override
  void onInit() {
    fullName.value = session.readRiderFullName() ?? '';
    profilePlaceHolder.value = profile;
    getProfile();
    super.onInit();
  }

  Future<void> uploadProfilePicture(fileUrl) async {
    try {
      var response = await userController.uploadProfiilePhotoAsync(fileUrl);
      if (response.status) {
        if (response.data.profilePhoto.isNotEmpty) {
          profilePhoto.value = response.data.profilePhoto;
        }
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void pickImage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result == null) {
      Get.defaultDialog(
          title: 'Information', content: const Text('No file selected'));
      return;
    } else {
      Get.defaultDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          title: 'Information',
          content: Column(
            children: [Text(result.files.first.name), const Divider()],
          ),
          onConfirm: () => uploadProfilePicture(result.files.first.path),
          onCancel: () {
            result.files.clear();
          },
          textConfirm: 'Save',
          textCancel: 'Cancel',
          confirmTextColor: primaryColor,
          cancelTextColor: validationErrorColor);
    }
  }

  void getProfile() async {
    var resp = await userController.userProfileAsync();
    if (resp.status) {
      profilePhoto.value = resp.data.profilePhoto ?? '';
    }
  }
}
