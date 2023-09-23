// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final int itemCount;

  ShimmerLoading({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              width: double.infinity,
              height: 18.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
