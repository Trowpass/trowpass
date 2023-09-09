import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'overlay_indeterminate_progress.dart';

OverlayIndeterminateProgress overlayLoader(bool isLoading) {
  return OverlayIndeterminateProgress(
      isLoading: isLoading,
      overlayBackgroundColor: background,
      progressColor: primaryColor,
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
