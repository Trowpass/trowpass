import 'package:flutter/material.dart';

class BankListLoading extends StatelessWidget {
  const BankListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: double.infinity,
        height: 18.0,
        color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
