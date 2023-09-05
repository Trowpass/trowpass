import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/add_new_card_controller.dart';
import '../../../shareds/utils/border_radius.dart';
import '../../../shareds/utils/card_month_input_formatter.dart';
import '../../../shareds/utils/card_number_input_formatter.dart';
import '../../../widgets/standard_button.dart';

class AddNewCardScreen extends StatelessWidget {
  AddNewCardScreen({super.key});

  final controller = Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarBrightness: Brightness.light, // For iOS
            statusBarIconBrightness: Brightness.light, // For Android
            systemNavigationBarColor: navigationBarBackground,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          title: Text(controller.title.value),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: controller.formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Card Holder Name', style: appStyles(16, null, FontWeight.w500)),
                        subtitle: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controller.cardHolderNameController,
                          decoration: InputDecoration(
                              hintText: 'Holder\'s name',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: grayscale),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: grayscale),
                              ),
                              prefixIcon: const Icon(Icons.add_card_rounded),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultBorderRadius))),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Card Number', style: appStyles(16, null, FontWeight.w500)),
                        subtitle: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(19),
                            CardNumberInputFormatter()
                          ],
                          controller: controller.cardNumberController,
                          decoration: InputDecoration(
                              hintText: 'Card number',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: grayscale),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: grayscale),
                              ),
                              prefixIcon: const Icon(Icons.add_card_rounded),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultBorderRadius))),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Expiry Date', style: appStyles(16, null, FontWeight.w500)),
                                subtitle: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    CardMonthInputFormatter()
                                  ],
                                  controller: controller.cardExpiryDateController,
                                  decoration: InputDecoration(
                                      hintText: 'MM/YY',
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: grayscale),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: grayscale),
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultBorderRadius))),
                                ))),
                        const VerticalDivider(
                          width: 2,
                        ),
                        Expanded(
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('CVV', style: appStyles(16, null, FontWeight.w500)),
                                subtitle: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  controller: controller.cardCvvController,
                                  decoration: InputDecoration(
                                      hintText: '0000',
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: grayscale),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: grayscale),
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultBorderRadius))),
                                ))),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: StandardButton(
                        text: 'Submit',
                        onPressed: () {
                          controller.trySubmit();
                        },
                      ))
                ])),
          ),
        ),
      ),
    );
  }
}
