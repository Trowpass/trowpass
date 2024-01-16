import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/rider/fund_virtual_card_controller.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/overlay_indeterminate_progress.dart';
import '../../widgets/standard_button.dart';
import '../../widgets/text_form_input.dart';

class FundVirtualCardScreen extends StatelessWidget {
  final controller = Get.put(FundVirtualCardController());

  FundVirtualCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Obx(
        () => OverlayIndeterminateProgress(
          isLoading: controller.isLoading.value,
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
                title: Text(
                  'Add Money',
                  style: appStyles(18, titleActive, FontWeight.w600),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8),
                        child: Form(
                          key: controller.formKey,
                          child: TextInputForm(
                            inputType: TextInputType.number,
                            enabled: true,
                            isPassword: false,
                            inputController: controller.topUpAmountController,
                            textLabel: 'Enter amount',
                            textHint: 'Enter amount',
                            autoCorrect: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            prefixIcon: const Icon(Icons.payments_outlined),
                            validator: (value) => value != null && value.isEmpty
                                ? 'Field can\'t be empty'
                                : null,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.topUpAmountController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 16, left: 8),
                        child: Text(
                          controller.balance.value,
                          style: appStyles(16, titleActive, FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: StandardButton(
                          text: 'Continue',
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.formKey.currentState!.save();
                              controller.fundVirtualCard();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
