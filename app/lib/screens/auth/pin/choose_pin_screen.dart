// ignore_for_file: prefer_const_constructors, prefer_is_empty, use_key_in_widget_constructors

import 'package:app/controllers/rider/create_pin_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChoosePinScreen extends StatelessWidget {
  final ChoosePinController controller = Get.put(ChoosePinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
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
                  'Enter PIN',
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
