import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/cards_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../shareds/utils/images.dart';
import '../../widgets/app_styles.dart';
import '../../widgets/standard_button.dart';
import '../get_transport_card/card_type.dart';

class CardsTabScreen extends StatelessWidget {
  CardsTabScreen({super.key});
  final controller = Get.put(CardsTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        title: Text(
          controller.title,
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Instantly get a virtual card to make transport payment easily on your favorite transport app",
                    style: appStyles(14, titleActive, FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(preview),
                const SizedBox(
                  height: 25,
                ),
                StandardButton(
                  text: 'Create Card',
                  onPressed: () {
                    Get.to(() => CardTypeScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
