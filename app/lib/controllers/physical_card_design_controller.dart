import 'package:app/screens/card/success_screen.dart';
import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhysicalCardDesignController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();

  void trySubmit() {
    Get.to(() => SuccessScreen(
          message:
              'Card request successful! You will be notified when its ready for pickup.',
          imageAsset: cardSuccess,
          onTap: () => Get.offAll(() => const HomeLandingTabScreen()),
        ));
  }
}
