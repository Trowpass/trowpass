import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  final controller = Get.put(OnBoardingController());

  OnBoardingScreen({super.key});

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
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: background,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Obx(() => CarouselSlider(
                carouselController: controller.pageController,
                options: CarouselOptions(
                  initialPage: controller.currentIndex.value,
                  aspectRatio: 16 / 9,
                  height: double.infinity,
                  viewportFraction: 1,
                  autoPlay: true,
                  disableCenter: true,
                  onPageChanged: (index, reason) => controller.currentIndex.value = index,
                ),
                items: controller.onBoardingItems.map((item) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: appStyles(18, titleActive, FontWeight.bold),
                        ),
                      ),
                      Image.asset(
                        width: 400,
                        height: 400,
                        item.imgString,
                        fit: BoxFit.contain,
                      ),
                    ],
                  );
                }).toList(),
              )),
          Positioned(
            bottom: 30,
            left: 30,
            child: Obx(() => AnimatedSmoothIndicator(
                  onDotClicked: (index) => controller.pageController.animateToPage(
                    index,
                    curve: Curves.easeIn,
                  ),
                  count: controller.onBoardingItems.length,
                  activeIndex: controller.currentIndex.value,
                  effect: const ExpandingDotsEffect(
                    offset: 8,
                    dotWidth: 16,
                    dotHeight: 8,
                    dotColor: scrollIndicatorColor,
                    activeDotColor: primaryColor,
                  ),
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: primaryColor,
        child: const Icon(Icons.arrow_forward),
        onPressed: () => Get.offAll(LoginScreen()),
      ),
    );
  }
}
