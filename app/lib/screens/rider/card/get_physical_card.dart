import 'package:app/controllers/physical_card_design_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetPhysicalCardScreen extends StatelessWidget {
  const GetPhysicalCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create card design',
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(design),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(height: 16),
                CardHolderField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardHolderField extends StatelessWidget {
  final cardDesignHolderInputController =
      Get.put(PhysicalCardDesignController());
  CardHolderField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: cardDesignHolderInputController.formKey,
        child: Column(
          children: [
            const LabelText(textLabel: "Enter Card holder Name"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController:
                  cardDesignHolderInputController.fullNameController,
              textLabel: 'Type here',
              textHint: 'Type here',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 25),
            StandardButton(
              text: 'Get Card',
              onPressed: () {
                if (cardDesignHolderInputController.formKey.currentState!
                    .validate()) {
                  cardDesignHolderInputController.trySubmit();
                }
              },
            ),
          ],
        ));
  }
}
