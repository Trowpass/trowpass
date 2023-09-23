import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:get/get.dart';

import '../../controllers/edit_profile_controller.dart';
import '../../shareds/utils/border_radius.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';
import '../../widgets/text_input.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextInput(
                      keyboardType: TextInputType.none,
                      enabled: true,
                      inputController: controller.profileController,
                      textLabel: 'Choose file',
                      textHint: 'Choose file',
                      isPassword: false,
                      prefixIcon: const Icon(
                        Icons.photo_camera,
                        size: 24,
                      ),
                      isReadOnly: false,
                    ),
                    const SizedBox(height: 10),
                    TextInputForm(
                      enabled: true,
                      inputController: controller.firstNameController,
                      textLabel: 'First Name',
                      textHint: 'First Name',
                      validatorMessage: 'Please enter first name',
                      isPassword: false,
                      autoCorrect: false,
                      prefixIcon: const Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextInputForm(
                      enabled: true,
                      inputController: controller.lastNameController,
                      textLabel: 'Last Name',
                      textHint: 'Last Name',
                      validatorMessage: 'Please enter last name',
                      isPassword: false,
                      autoCorrect: false,
                      prefixIcon: const Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        maxLines: 2,
                        enabled: true,
                        controller: controller.bioController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.place,
                            size: 24,
                          ),
                          labelText: 'Address',
                          labelStyle: appStyles(15, null, null),
                          hintText: 'Address',
                          errorStyle:
                              appStyles(null, validationErrorColor, null),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    TextInputForm(
                      inputType: TextInputType.phone,
                      enabled: true,
                      inputController: controller.phoneNumberController,
                      textLabel: 'Phone Number',
                      textHint: 'Phone Number',
                      validatorMessage: 'Please enter a valid number',
                      isPassword: false,
                      autoCorrect: false,
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        maxLines: 2,
                        enabled: true,
                        controller: controller.bioController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.edit,
                            size: 24,
                          ),
                          labelText: 'Bio',
                          labelStyle: appStyles(15, null, null),
                          hintText: 'Bio',
                          errorStyle:
                              appStyles(null, validationErrorColor, null),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            borderSide: const BorderSide(color: primaryColor),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your bio data';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    StandardButton(
                      text: 'Save Changes',
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                        }
                      },
                    ),
                  ],
                ))),
      ),
    );
  }
}
