// ignore_for_file: prefer_const_constructors, prefer_is_empty, use_key_in_widget_constructors

import 'package:app/controllers/confirm_pin_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Choose PIN',
        style: appStyles(
          20,
          titleActive,
          FontWeight.w600
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                     GestureDetector(
        onTap: () {
          if (controller.pin.value.length > i) {
            controller.deleteDigit(i);
          }
        },
                      child: SizedBox(
                        width: 80,
                        child: TextField(
                          focusNode: controller.focusNodes[i],
                          controller: TextEditingController(
                              text: controller.pin.value.length > i ? '*' : ''),
                          enabled: controller.pin.value.length <= i,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 24),
                          onChanged: (value) {
                            if (value.length > 1) {
                              value = value.substring(value.length - 1);
                            }
                    
                            if (value.length == 1) {
                              controller.updatePin(value, i);
                            } else if (value.isEmpty &&
                                controller.pin.value.length > 0) {
                              controller.deleteDigit(i);
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 22),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: grayscale ),
                              borderRadius: BorderRadius.circular(pinBorderRadius)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grayscale ),
                               borderRadius: BorderRadius.circular(pinBorderRadius)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grayscale ),
                               borderRadius: BorderRadius.circular(pinBorderRadius)
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 44),
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



