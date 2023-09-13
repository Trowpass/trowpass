import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/virtual_card_design_controller.dart';
import '../../widgets/overlay_indeterminate_progress.dart';

class GetVirtualCardScreen extends StatelessWidget {
  final controller = Get.put(VirtualCardDesignController());

  GetVirtualCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: controller.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
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
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Create virtual card',
                style: appStyles(20, titleActive, FontWeight.w600),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Image.asset(preview),
                      const SizedBox(height: 16),
                      StandardButton(
                        text: 'Get Card',
                        onPressed: () => controller.createVirtualCard(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
