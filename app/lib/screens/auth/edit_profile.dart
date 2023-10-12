import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/all_state_list.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:get/get.dart';

import '../../controllers/edit_profile_controller.dart';
import '../../shareds/utils/border_radius.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final controller = Get.put(EditProfileController());

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
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('First Name'),
                                subtitle: TextInputForm(
                                  enabled: true,
                                  inputController:
                                      controller.firstNameController,
                                  validatorMessage: 'Please enter first name',
                                  isPassword: false,
                                  autoCorrect: false,
                                )),
                            const SizedBox(height: 5),
                            ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Last Name'),
                                subtitle: TextInputForm(
                                  enabled: true,
                                  inputController:
                                      controller.lastNameController,
                                  validatorMessage: 'Please enter last name',
                                  isPassword: false,
                                  autoCorrect: false,
                                )),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Phone Number'),
                              subtitle: TextInputForm(
                                inputType: TextInputType.phone,
                                enabled: true,
                                inputController:
                                    controller.phoneNumberController,
                                validatorMessage: 'Please enter a valid number',
                                isPassword: false,
                                autoCorrect: false,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Bio Data'),
                                subtitle: TextInputForm(
                                  enabled: true,
                                  inputController: controller.bioController,
                                  validatorMessage:
                                      'Please enter your bio data',
                                  isPassword: false,
                                  autoCorrect: false,
                                )),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Select Country'),
                              subtitle: DropdownButtonFormField(
                                elevation: 1,
                                decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: grayscale),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            defaultBorderRadius))),
                                onChanged: (Object? newSeleted) {
                                  controller.onSetSelectedCountry(newSeleted);
                                },
                                isExpanded: true,
                                validator: (value) => value == 'Select'
                                    ? 'Please select country'
                                    : null,
                                value: controller.selectedCountry.value,
                                items: controller.country.map((selectedType) {
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    child: Text(
                                      selectedType,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Select State'),
                              subtitle: TextInputForm(
                                onTap: () => showStateLists(context),
                                enabled: true,
                                readOnly: true,
                                inputController: controller.stateController,
                                validatorMessage: 'Please select state',
                                isPassword: false,
                                autoCorrect: false,
                                suffixIcon: InkWell(
                                  onTap: () => showStateLists(context),
                                  child: const Icon(Icons.arrow_drop_down),
                                ),
                                initialValue: controller.stateController.text,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('City/LGA'),
                              subtitle: TextInputForm(
                                autoCorrect: false,
                                enabled: true,
                                isPassword: false,
                                inputController: controller.cityController,
                                validator: (value) =>
                                    value != null && value.isEmpty
                                        ? 'Field can\'t be empty'
                                        : null,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.cityController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.close_outlined,
                                      size: 15,
                                    )),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Address'),
                              subtitle: TextInputForm(
                                autoCorrect: false,
                                enabled: true,
                                isPassword: false,
                                inputController:
                                    controller.streetAddressController,
                                validator: (value) =>
                                    value != null && value.isEmpty
                                        ? 'Field can\'t be empty'
                                        : null,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.streetAddressController
                                          .clear();
                                    },
                                    icon: const Icon(
                                      Icons.close_outlined,
                                      size: 15,
                                    )),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Postal Code'),
                              subtitle: TextInputForm(
                                inputType: TextInputType.number,
                                autoCorrect: false,
                                enabled: true,
                                isPassword: false,
                                inputController:
                                    controller.postalCodeController,
                                validator: (value) =>
                                    value != null && value.isEmpty
                                        ? 'Field can\'t be empty'
                                        : null,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.postalCodeController.clear();
                                    },
                                    icon: const Icon(
                                      Icons.close_outlined,
                                      size: 15,
                                    )),
                              ),
                            ),
                            const SizedBox(height: 5),
                            StandardButton(
                              text: 'Save Changes',
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  controller.updateProfile(context);
                                }
                              },
                            ),
                          ],
                        ))),
              ),
            ))));
  }

  Future<dynamic> showStateLists(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return StateListModalSheet(
          onStateSelected: (selectedCompany) {
            controller.onSetSelectedState(selectedCompany);
            controller.stateController.text = selectedCompany;
            Navigator.pop(context);
          },
          allStates: controller.states,
          initialSelectedState: controller.selectedState.value,
        );
      },
    );
  }
}
