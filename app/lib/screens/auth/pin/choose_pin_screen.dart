// ignore_for_file: prefer_const_constructors, prefer_is_empty, use_key_in_widget_constructors

import 'package:app/controllers/create_pin_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePinScreen extends StatelessWidget {
  final ChoosePinController controller = Get.put(ChoosePinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
        centerTitle: true,
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
                  'Enter PIN',
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
                    SizedBox(
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
                            controller.updatePin(value);
                          } else if (value.isEmpty &&
                              controller.pin.value.length > 0) {
                            controller.deletePin();
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
                ],
              ),
              SizedBox(height: 44),
              StandardButton(
              text: 'CONTINUE',
              onPressed: () {
                controller.navigateToConfirmPin();
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
