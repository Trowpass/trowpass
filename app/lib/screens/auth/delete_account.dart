import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:get/get.dart';

import '../../controllers/bloc/delete_account_controller.dart';
import '../../widgets/standard_button.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});
  final controller = Get.put(DeleteAccountController());

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
                title: const Text('Delete Account'),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('It\'s sad to see you go'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextInputForm(
                            inputController: controller.reasonController,
                            isPassword: false,
                            autoCorrect: false,
                            enabled: true),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Please Note:'),
                        Text('Trowpass is ...'),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => RadioListTile(
                              selected: false,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                  'By confirming, we assume that you have read and understood the information therein above'),
                              activeColor: primaryColor,
                              value: controller.selectedOption.value,
                              groupValue: controller.selectedOption.value,
                              onChanged: (value) {
                                controller.selectedOption.value = value!;
                              },
                            )),
                        CheckboxListTile(
                          //checkbox positioned at left
                          value: controller.isChecked.value,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? value) {
                            setState(() {
                              check3 = value;
                            });
                          },
                          title: Text("Do you really want to learn Flutter?"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                StandardButton(
                                  text: 'CONTINUE',
                                  onPressed: () async {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.formKey.currentState!.save();
                                      // controller.updateProfile(context);
                                    }
                                  },
                                ),
                              ],
                            ))
                      ],
                    )),
              ),
            ))));
  }
}
