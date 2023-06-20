import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_navigation_item.dart';

buildBottomNavigationMenu(
    int currentIndex, void Function(int)? onChangeTabIndex) {
  return BottomNavigationBar(
    unselectedItemColor: grayscale,
    selectedItemColor: primaryColor,
    selectedLabelStyle:
        appStyleWithMoreProps(12, primaryColor, FontWeight.w500, null),
    unselectedLabelStyle:
        appStyleWithMoreProps(12, grayscale, FontWeight.w500, null),
    onTap: onChangeTabIndex,
    currentIndex: currentIndex,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: background,
    elevation: 0,
    items: [
      bottomNavigationBarItem(icon: Icons.home_rounded, label: 'Home'),
      bottomNavigationBarItem(
          icon: Icons.work_history_rounded, label: 'History'),
      bottomNavigationBarItem(
          icon: Icons.request_quote_rounded, label: 'Bills'),
      bottomNavigationBarItem(icon: Icons.person_rounded, label: 'Profile')
    ],
  );
}
