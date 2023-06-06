import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

import '../shareds/utils/app_colors.dart';

ListTile sideNavBarItem(IconData icon, String title, Color? iconColor,
    void Function()? onTapAction) {
  return ListTile(
    horizontalTitleGap: 2,
    textColor: background,
    iconColor: iconColor,
    leading: Icon(
      icon,
      color: background,
    ),
    title: Text(
      title,
      style: appStyles(16, null, null),
    ),
    onTap: onTapAction,
  );
}
