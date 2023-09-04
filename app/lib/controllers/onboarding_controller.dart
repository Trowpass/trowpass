import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../screens/onboarding/onboarding_items.dart';
import '../shareds/utils/images.dart';

class OnBoardingController extends GetxController {
  final currentIndex = 0.obs;
  final pageController = CarouselController();

  final List<OnBoardingItem> onBoardingItems = [
    OnBoardingItem(finance, 'One app, multiple rides'),
    OnBoardingItem(finance, 'Seamless payment on the go'),
    OnBoardingItem(finance, 'Trowpass your No.1 travel partner'),
  ];
}
