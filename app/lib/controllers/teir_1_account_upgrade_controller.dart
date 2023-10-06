import 'dart:io';

import 'package:app/screens/kyc/tier_1_account_address_Upgrade.dart';
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
      upgradeDataArgs = {
        'birth_place': placeOfBirthController.text,
        'd_o_b': DateTime.tryParse(dobController.text),
        'gnd': selectedGender.value,
        'file_path': filePath.value,
        'bvn': bvnController.text
      };
      Get.to(() => TeirOneAccountAddressUpgradeScreen(),
          arguments: upgradeDataArgs);
    }
  }
}
