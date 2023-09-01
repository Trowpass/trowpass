// ignore_for_file: prefer_const_constructors, prefer_is_empty, use_key_in_widget_constructors

import 'package:app/controllers/confirm_pin_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class ConfirmPinScreen extends StatelessWidget {
  final ConfirmPinController controller = Get.put(ConfirmPinController());

  @override
  Widget build(BuildContext context) {
    final String? chosenPin = Get.arguments;
    return Obx(() => OverlayLoaderWithAppIcon(
        isLoading: controller.isLoaded.value,
        overlayBackgroundColor: background,
        circularProgressColor: primaryColor,
        appIcon: appLogo(70, 70),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'Choose PIN',
              style: appStyles(20, titleActive, FontWeight.w600),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Re-Enter PIN',
                      style: appStyles(
                        16,
                        Colors.black,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Form(
                    key: controller.formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.codeOneController,
                            validator: (value) =>
                                value != null && value.isEmpty ? "" : null,
                            onChanged: (value) => value.length == 1
                                ? FocusScope.of(context).nextFocus()
                                : null,
                            decoration: InputDecoration(
                              hintText: '*',
                              errorStyle: const TextStyle(height: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.codeTwoController,
                            validator: (value) =>
                                value != null && value.isEmpty ? "" : null,
                            onChanged: (value) => value.length == 1
                                ? FocusScope.of(context).nextFocus()
                                : FocusScope.of(context).previousFocus(),
                            decoration: InputDecoration(
                              hintText: '*',
                              errorStyle: const TextStyle(height: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.codeThreeController,
                            validator: (value) =>
                                value != null && value.isEmpty ? "" : null,
                            onChanged: (value) => value.length == 1
                                ? FocusScope.of(context).nextFocus()
                                : FocusScope.of(context).previousFocus(),
                            decoration: InputDecoration(
                              hintText: '*',
                              errorStyle: const TextStyle(height: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            obscureText: true,
                            controller: controller.codeFourController,
                            validator: (value) =>
                                value != null && value.isEmpty ? "" : null,
                            onChanged: (value) => value.length == 1
                                ? FocusScope.of(context).nextFocus()
                                : null,
                            decoration: InputDecoration(
                              hintText: '*',
                              errorStyle: const TextStyle(height: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  StandardButton(
                    text: 'Create',
                    onPressed: () {
                      controller.validatePinAndCreate(chosenPin!);
                    },
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
