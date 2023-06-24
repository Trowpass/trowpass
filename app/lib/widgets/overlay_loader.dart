import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import 'app_logo.dart';

OverlayLoaderWithAppIcon overlayLoader(bool isLoading) {
  return OverlayLoaderWithAppIcon(
      isLoading: isLoading,
      borderRadius: 30,
      overlayBackgroundColor: background,
      circularProgressColor: primaryColor,
      appIcon: appLogo(70, 70),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          elevation: 0,
        ),
        body: const Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [],
          ),
        ),
      ));
}
