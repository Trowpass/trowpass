// ignore: file_names
import 'dart:io';

import 'package:app/controllers/teir_1_account_upgrade_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../shareds/utils/images.dart';

class TeirOneAccountUpgradeScreen extends StatefulWidget {
  const TeirOneAccountUpgradeScreen({super.key});

  @override
  State<TeirOneAccountUpgradeScreen> createState() => _TeirOneAccountUpgradeScreenState();
}

class _TeirOneAccountUpgradeScreenState extends State<TeirOneAccountUpgradeScreen> {
  final controller = Get.put(TeirOneAccountUpgradeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: background,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: primaryColor,
                  statusBarBrightness: Brightness.light, // For iOS
                  statusBarIconBrightness: Brightness.light, // For Android
                  systemNavigationBarColor: navigationBarBackground,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                elevation: 0.0,
                backgroundColor: background,
                title: Text('Upgrading Account to Tier 1', style: appStyles(18, titleActive, FontWeight.w600)),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(notificationIcon),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Form(
                                key: controller.formKey,
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Place of Birth'),
                                      subtitle: TextInputForm(
                                        autoCorrect: false,
                                        enabled: true,
                                        isPassword: false,
                                        inputController: controller.placeOfBirthController,
                                        textHint: 'place of birth',
                                        validator: (value) =>
                                            value != null && value.isEmpty ? 'Field can\'t be empty' : null,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.placeOfBirthController.clear();
                                            },
                                            icon: const Icon(
                                              Icons.close_outlined,
                                              size: 20,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Date of Birth'),
                                      subtitle: TextInputForm(
                                        autoCorrect: false,
                                        inputType: TextInputType.datetime,
                                        enabled: true,
                                        isPassword: false,
                                        inputController: controller.dobController,
                                        textHint: 'Date of birth',
                                        validator: (value) =>
                                            value != null && value.isEmpty ? 'Field can\'t be empty' : null,
                                        suffixIcon: IconButton(
                                            onPressed: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(DateTime.now().year - 120),
                                                lastDate: DateTime.now(),
                                                builder: (context, child) {
                                                  return Theme(
                                                      data: ThemeData.light().copyWith(
                                                        primaryColor: primaryColor,
                                                      ),
                                                      child: child!);
                                                },
                                              );
                                              if (pickedDate != null) {
                                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                controller.dobController.text = formattedDate;
                                                Get.focusScope!.unfocus();
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.calendar_month_outlined,
                                              size: 20,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Gender'),
                                      subtitle: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: primaryColor),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: grayscale),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(defaultBorderRadius))),
                                        onChanged: (Object? newSeleted) {
                                          controller.onSetSelectedGender(newSeleted);
                                        },
                                        isExpanded: true,
                                        validator: (value) =>
                                            value != null && value == 'Select gender' ? 'Please select genger' : null,
                                        value: controller.selectedGender.value,
                                        items: controller.gender.map((selectedType) {
                                          return DropdownMenuItem(
                                            value: selectedType,
                                            child: Text(
                                              selectedType,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Visibility(
                                        visible: controller.isUploadButtonClicked.value,
                                        child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text('Your image'),
                                            subtitle: ElevatedButton.icon(
                                              icon: const Icon(
                                                Icons.upload_file_outlined,
                                                color: gray,
                                              ),
                                              onPressed: () async {
                                                _showPicker(context: context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(defaultBorderRadius)),
                                                backgroundColor: offWhite,
                                                minimumSize: const Size(double.infinity, 60),
                                                side: const BorderSide(color: grayscale),
                                              ),
                                              label: Text(
                                                'Upload from Gallery or Camera (Selfie)',
                                                style: appStyles(16, gray, FontWeight.w400),
                                              ),
                                            ))),
                                    Visibility(
                                        visible: controller.isFileUpload.value,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text('Your image'),
                                          subtitle: Container(
                                              decoration: BoxDecoration(border: Border.all(color: border)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: SizedBox(
                                                        height: 100.0,
                                                        child: controller.galleryFile == null
                                                            ? const Icon(Icons.broken_image_outlined)
                                                            : Image.file(
                                                                controller.galleryFile!,
                                                                filterQuality: FilterQuality.high,
                                                                fit: BoxFit.fill,
                                                              ),
                                                      )),
                                                  Expanded(
                                                      flex: 5,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          _showPicker(context: context);
                                                        },
                                                        child: const ListTile(
                                                          horizontalTitleGap: 0,
                                                          leading: Icon(Icons.delete_outline_outlined),
                                                          title: Text('Replace image'),
                                                        ),
                                                      ))
                                                ],
                                              )),
                                        )),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: StandardButton(
                              text: 'Continue',
                              onPressed: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.submitTierOneKycUpgrade(context);
                                }
                              },
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ), // here
          ),
        ));
  }

  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await controller.picker
        .pickImage(source: img, preferredCameraDevice: CameraDevice.front, requestFullMetadata: false, imageQuality: 10);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          controller.galleryFile = File(pickedFile!.path);
          controller.isUploadButtonClicked.value = false;
          controller.isFileUpload.value = true;
          controller.filePath.value = pickedFile.path;
        } else {
          Get.snackbar('Profile Picture', 'Nothing was selected');
        }
      },
    );
  }
}
