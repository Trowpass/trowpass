// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../shareds/utils/app_colors.dart';

class CardsTabScreen extends StatelessWidget {
  CardsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body:Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Text("Hello Fleet Manager Card tab is here"),
          ),
        ],
      ),
    );
  }
}
