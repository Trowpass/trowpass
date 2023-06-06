import 'package:flutter/material.dart';

bottomNavigationBarItem({IconData? icon, String? label}) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      size: 30,
    ),
    label: label,
  );
}
