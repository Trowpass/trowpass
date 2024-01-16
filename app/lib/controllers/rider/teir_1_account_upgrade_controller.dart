import 'dart:io';

import 'package:app/controllers/rider/bloc/user_controller.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/services/requests/put_requests/tier_one_request.dart';
import 'package:app/shareds/constants/file_upload_purpose.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TeirOneAccountUpgradeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  late Map<String, dynamic> upgradeDataArgs;

  List<dynamic> gender = ['Select gender', 'Male', 'Female'];
  final selectedGender = 'Select gender'.obs;

  final isLoaded = false.obs;
  final isUploadButtonClicked = false.obs;
  final isFileUpload = false.obs;
  final filePath = ''.obs;

  File? galleryFile;
  final picker = ImagePicker();
  UserController userController = UserController();
  GetSessionManager getSession = GetSessionManager();

  @override
  void onInit() async {
    isLoaded.value = false;
    isUploadButtonClicked.value = true;
    isFileUpload.value = false;
    filePath.value = '';

    super.onInit();
  }

  void onSetSelectedGender(Object? value) {
    selectedGender.value = value.toString();
  }

  Future submitTierOneKycUpgrade(BuildContext context) async {
    try {
      isLoaded.value = true;
      if (filePath.isEmpty) {
        Get.snackbar('File', 'File not selected');
        isLoaded.value = false;
      } else {
        var uploadPassportResponse = await userController.uploadFileAsync(
          purpose: FileUploadPurpose.profilePicture,
          filepath: filePath.value,
        );
        if (uploadPassportResponse.status) {
          var response =
              await userController.t1AccountUpgradeAsync(TierOneRequest(
                  placeOfBirth: placeOfBirthController.text.trim(),
                  dateOfBirth: DateTime.parse(dobController.text.trim()),
                  gender: selectedGender.value.trim(),
                  imagePath: uploadPassportResponse.path.trim(),
                  address: T1Address(
                    street: getSession.readProfileStreet(),
                    city: getSession.readProfileCity(),
                    state: getSession.readProfileState(),
                    country: getSession.readProfileCountry(),
                    postalCode: getSession.readProfilePostalCode(),
                  )));
          if (response.status) {
            isLoaded.value = false;
            Get.defaultDialog(
                onWillPop: () async => showExitPopup(context),
                barrierDismissible: false,
                titlePadding: const EdgeInsets.only(top: 15),
                contentPadding: const EdgeInsets.all(15),
                title: 'Account Upgrade',
                content: const Column(
                  children: [
                    Divider(),
                    Text(
                        'Congratulations! Your account has been upgraded to Tier 1 account successfully.')
                  ],
                ),
                confirm: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.login_outlined),
                    onPressed: () => Get.offAll(() => LoginScreen()),
                    label: const Text('Please Login to Continue'),
                  ),
                ));
          } else {
            isLoaded.value = false;
            Get.snackbar('Information', response.message!,
                backgroundColor: dialogInfoBackground,
                snackPosition: SnackPosition.BOTTOM);
          }
        }
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Action Required'),
            content: const Text(
                'You have a pending action to be completed. Do you want to close it?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: dialogInfoBackground),
                onPressed: () => Get.back(closeOverlays: false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
