import 'package:app/controllers/rider/card_details_controller.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CopyCardDetailsScreen extends StatelessWidget {
  final controller = Get.put(CardDetailsController());

  CopyCardDetailsScreen({super.key});

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Virtual Card Details',
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
        actions: const <Widget>[],
      ),
      body: _buildCardDetails(),
    );
  }

  Widget _buildCardDetails() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: dialogInfoBackground.withOpacity(0.3),
          border: Border.all(color: greyLight.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return _buildDetailRow(
                  label: 'Card Holder',
                  value: controller.customerName.value,
                );
              }),
              _buildDetailRow(
                label: 'Card Number',
                value: controller.pan.value,
              ),
              _buildDetailRow(
                label: 'CVV',
                value: controller.cvv.value,
              ),
              _buildDetailRow(
                label: 'Expiry Date',
                value: controller.expiryDate.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: appStyles(16, titleActive, null),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: appStyles(18, titleActive, FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () => controller.copyCardDetails(value),
              icon: const Icon(Icons.copy_all_rounded),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
