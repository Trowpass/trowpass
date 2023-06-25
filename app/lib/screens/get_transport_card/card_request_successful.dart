// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:flutter/material.dart';

class CardRequestSucessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double spacing = screenSize.height * 0.21;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                cardSuccess,
              ),
              const SizedBox(height: 20),
              Text(
                'Card request successful! You will be notified when its ready for pickup.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: spacing),
              StandardButton(
                text: 'Done',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
