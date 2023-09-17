import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/overlay_indeterminate_progress.dart';
import 'package:app/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/card_display_controller.dart';
import '../../shareds/utils/app_colors.dart';
import '../../widgets/app_styles.dart';

class CardDisplayScreen extends StatelessWidget {
  final controller = Get.put(CardDisplayController());
  CardDisplayScreen({super.key});

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
          'Create virtual card',
          style: appStyles(20, titleActive, FontWeight.w600),
        ),
        actions: const <Widget>[
          //  IconButton(
          //    icon: const Icon(
          //      Icons.more_vert,
          //      color: Colors.black,
          //    ),
          //    onPressed: () {},
          //  ),
        ],
      ),
      body: OverlayIndeterminateProgress(
        isLoading: controller.isLoading.value,
        progressColor: primaryColor,
        overlayBackgroundColor: background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(blueCard),
              Column(
                children: [
                  Text(
                    controller.balance.value,
                    style: appStyles(14, titleActive, null),
                  ),
                  const Text('Balance'),
                ],
              ),
              TransparentButton(
                text: 'Add Money',
                icon: const Icon(
                  Icons.add,
                  color: titleActive,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
