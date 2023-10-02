import 'package:app/controllers/teir_1_account_address_apgrade_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/all_state_list.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TeirOneAccountAddressUpgradeScreen extends StatelessWidget {
  TeirOneAccountAddressUpgradeScreen({super.key});
  final controller = Get.put(TeirOneAccountAddressUpgradeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
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
                title: Text('Address',
                    style: appStyles(18, titleActive, FontWeight.w600)),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
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
                                      title: const Text('Street'),
                                      subtitle: TextInputForm(
                                        autoCorrect: false,
                                        enabled: true,
                                        isPassword: false,
                                        inputController:
                                            controller.streetController,
                                        textHint: 'street address',
                                        validator: (value) =>
                                            value != null && value.isEmpty
                                                ? 'Field can\'t be empty'
                                                : null,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.streetController
                                                  .clear();
                                            },
                                            icon: const Icon(
                                              Icons.close_outlined,
                                              size: 15,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('City'),
                                      subtitle: TextInputForm(
                                        autoCorrect: false,
                                        enabled: true,
                                        isPassword: false,
                                        inputController:
                                            controller.cityController,
                                        textHint: 'city/town',
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Country'),
                                      subtitle: DropdownButtonFormField(
                                        elevation: 1,
                                        decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: primaryColor),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: grayscale),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        defaultBorderRadius))),
                                        onChanged: (Object? newSeleted) {
                                          controller
                                              .onSetSelectedCountry(newSeleted);
                                        },
                                        isExpanded: true,
                                        validator: (value) => value == 'Select'
                                            ? 'Please select country'
                                            : null,
                                        value: controller.selectedCountry.value,
                                        items: controller.country
                                            .map((selectedType) {
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
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('State'),
                                      subtitle: TextInputForm(
                                        enabled: true,
                                        inputController:
                                            controller.stateController,
                                        textHint: 'Select state',
                                        validatorMessage: 'Please select state',
                                        isPassword: false,
                                        autoCorrect: false,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0)),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              builder: (BuildContext context) {
                                                return StateListModalSheet(
                                                  onStateSelected:
                                                      (selectedCompany) {
                                                    controller
                                                        .onSetSelectedState(
                                                            selectedCompany);
                                                    controller.stateController
                                                        .text = selectedCompany;
                                                    Navigator.pop(context);
                                                  },
                                                  allStates: controller.states,
                                                  initialSelectedState:
                                                      controller
                                                          .selectedState.value,
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              const Icon(Icons.arrow_drop_down),
                                        ),
                                        initialValue:
                                            controller.stateController.text,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                                        textHint: 'postal code',
                                        validator: (value) =>
                                            value != null && value.isEmpty
                                                ? 'Field can\'t be empty'
                                                : null,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.postalCodeController
                                                  .clear();
                                            },
                                            icon: const Icon(
                                              Icons.close_outlined,
                                              size: 15,
                                            )),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: StandardButton(
                              text: 'Submit',
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
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
}
