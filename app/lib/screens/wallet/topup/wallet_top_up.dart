import 'package:app/shareds/utils/border_radius.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/wallet_top_up_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/currency_format.dart';
import '../../../widgets/overlay_indeterminate_progress.dart';
import '../../../widgets/standard_button.dart';

class WalletTopUpScreen extends StatelessWidget {
  WalletTopUpScreen({super.key});
  final controller = Get.put(WalletTopUpController());

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
                title: Text('Topup your wallet',
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
                  onPressed: () {
                    Get.back();
                  },
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(yellowCard),
                                  fit: BoxFit.fill)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      'Credit Card',
                                      style:
                                          appStyles(14, null, FontWeight.w300),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Obx(() => Text(
                                            controller
                                                    .showAccountBalance.isFalse
                                                ? '${currencyFormat(context).currencySymbol}${formatCurrency(controller.accountBalance.value)}'
                                                : controller
                                                    .hideAccountBalance(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    width: 0,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            controller
                                                    .showAccountBalance.value =
                                                !controller
                                                    .showAccountBalance.value;
                                          },
                                          icon: Obx(() => controller
                                                  .showAccountBalance.isFalse
                                              ? const Icon(
                                                  Icons.visibility_off_rounded)
                                              : const Icon(
                                                  Icons.visibility_rounded))),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(visaCard),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          controller.cardDetails.value,
                                          style: appStyles(
                                              11, null, FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.customerName.value,
                                  style: appStyles(18, null, FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Amount'),
                            subtitle: Form(
                                key: controller.formKey,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.topUpAmountController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      hintText: '0.0',
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: grayscale),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: grayscale),
                                      ),
                                      prefixIcon:
                                          const Icon(Icons.payments_outlined),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller
                                                .shouldEntryAmountBeCleared
                                                .value = true;
                                            controller.clearTopUpAmount();
                                          },
                                          icon: const Icon(Icons.close)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              defaultBorderRadius))),
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: StandardButton(
                              text: 'Continue to pay',
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.formKey.currentState!.save();
                                  // go to checkout page
                                  controller.checkout(context);
                                }
                              },
                            ))
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
