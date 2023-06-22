import 'package:flutter/material.dart';

import '../shareds/utils/images.dart';

Widget appLogo(double h, double w) {
  AssetImage assetImage = const AssetImage(mainLogo);
  Image img = Image(
    image: assetImage,
  );

  return SizedBox(height: h, width: w, child: img);
}
