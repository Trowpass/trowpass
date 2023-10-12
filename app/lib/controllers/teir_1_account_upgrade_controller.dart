import 'dart:io';

import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/screens/kyc/tier_1_account_address_Upgrade.dart';
import 'package:app/shareds/constants/file_upload_purpose.dart';
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

  Future getUpgradeData() async {
    if (filePath.isEmpty) {
      Get.snackbar('File', 'File not selected');
    } else {
      await uploadImage();
      Get.to(() => TeirOneAccountAddressUpgradeScreen(),
          arguments: upgradeDataArgs);
    }
  }

  Future uploadImage() async {
    try {
      var response = await userController.uploadFileAsync(
        purpose: FileUploadPurpose.profilePicture,
        filepath: filePath.value,
      );
      if (response.status) {
        upgradeDataArgs = {
          'birth_place': placeOfBirthController.text,
          'd_o_b': DateTime.tryParse(dobController.text),
          'gnd': selectedGender.value,
          'file_path': response.path,
          'bvn': bvnController.text
        };
      } else {
        Get.defaultDialog(
          title: 'Information',
          content: Text(
            response.message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
