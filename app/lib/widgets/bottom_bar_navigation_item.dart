import 'package:flutter/material.dart';

bottomNavigationBarItem({IconData? icon, String? label}) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      size: 24,
    ),
    label: label,
  );
}
