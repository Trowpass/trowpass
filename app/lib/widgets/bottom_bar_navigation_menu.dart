import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_bar_navigation_item.dart';

buildBottomNavigationMenu(int currentIndex, void Function(int)? onChangeTabIndex) {
  return BottomNavigationBar(
    selectedItemColor: primaryColor,
    selectedLabelStyle: appStyleWithMoreProps(12, primaryColor, FontWeight.w500, null),
    unselectedLabelStyle: appStyleWithMoreProps(12, grayscale, FontWeight.w500, null),
    onTap: onChangeTabIndex,
    currentIndex: currentIndex,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: background,
    elevation: 0,
    items: [
      bottomNavigationBarItem(
        icon: SvgPicture.asset(
          home,
          colorFilter: ColorFilter.mode(getCurrentColor(currentIndex == 0), BlendMode.srcIn),
        ),
        label: 'Home',
      ),
      bottomNavigationBarItem(
        icon: SvgPicture.asset(
          history,
          colorFilter: ColorFilter.mode(getCurrentColor(currentIndex == 1), BlendMode.srcIn),
        ),
        label: 'History',
      ),
      bottomNavigationBarItem(
        icon: SvgPicture.asset(
          bill,
          colorFilter: ColorFilter.mode(getCurrentColor(currentIndex == 2), BlendMode.srcIn),
        ),
        label: 'Bills',
      ),
      bottomNavigationBarItem(
        icon: SvgPicture.asset(
          person,
          colorFilter: ColorFilter.mode(getCurrentColor(currentIndex == 3), BlendMode.srcIn),
        ),
        label: 'Profile',
      )
    ],
  );
}

Color getCurrentColor(bool isSelected) {
  return isSelected ? primaryColor : grayscale;
}
