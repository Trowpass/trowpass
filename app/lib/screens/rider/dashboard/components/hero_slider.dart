// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:app/shareds/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HeroController extends GetxController {
  var currentIndex = 0.obs;

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}

class ImageSlider extends StatelessWidget {
  final HeroController controller = Get.put(HeroController());

  List<String> imageList = [
    slide1,
    slide1,
    slide1,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<HeroController>(
          builder: (controller) => CarouselSlider(
            options: CarouselOptions(
              height: 105,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: controller.onPageChanged,
            ),
            items: imageList.map((image) {
              return Image.asset(
                image,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
        ),
        GetBuilder<HeroController>(
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.map((image) {
              int index = imageList.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentIndex.value == index
                      ? Colors.black
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
