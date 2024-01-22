import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/payment_method_controller.dart';
import '../../../shareds/utils/app_colors.dart';
import '../../../widgets/app_styles.dart';
import '../../../widgets/currency_format.dart';
import '../../../widgets/overlay_indeterminate_progress.dart';

class PaymentMethodScreen extends StatelessWidget {
  final controller = Get.put(PaymentMethodController());

  PaymentMethodScreen({super.key});

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
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: primaryColor,
                  statusBarBrightness: Brightness.light, // For iOS
                  statusBarIconBrightness: Brightness.light, // For Android
                  systemNavigationBarColor: navigationBarBackground,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          ListTile(
                            title: Text(
                              'Select Payment Option',
                              textAlign: TextAlign.center,
                              style:
                                  appStyles(16, titleActive, FontWeight.bold),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 16,
                            child: IconButton(
                              onPressed: Get.back,
                              icon: const Icon(Icons.close, color: titleActive),
                            ),
                          )
                        ],
                      ),
                      //   const SizedBox(height: 8),
                      Text('You pay',
                          style: appStyles(14, null, FontWeight.w400)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Text(
                          '${currencyFormat.currencySymbol}${formatCurrency(double.parse(controller.amount))}',
                          style: appStyles(24, primaryColor, FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildRadio(context, value: controller.payWithCard.value),
                      const SizedBox(height: 16),
                      _buildRadio(context, value: controller.payWithBank.value),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: StandardButton(
                              text: 'Pay Now',
                              onPressed: () => controller.payNow(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildRadio(BuildContext context, {required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: primaryColor.withOpacity(0.2),
          onTap: () {
            controller.paymentOption.value = value;
            if (controller.paymentOption.value ==
                controller.payWithBank.value) {
              controller.paymentWithBankTransferDetails(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: greyLight.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: greyLight.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Icon(
                  value == controller.payWithCard.value
                      ? Icons.payment
                      : Icons.account_balance,
                  color: primaryColor.withAlpha(150),
                ),
              ),
              trailing: Obx(() => Radio(
                    activeColor: primaryColor,
                    value: value,
                    groupValue: controller.paymentOption.value,
                    onChanged: (value) {
                      controller.paymentOption.value = value!;
                    },
                  )),
              title: Text(
                value,
                style: appStyles(14, titleActive, FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
