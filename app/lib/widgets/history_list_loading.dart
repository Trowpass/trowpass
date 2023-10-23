import 'package:flutter/material.dart';

class HistoryListLoading extends StatelessWidget {
  const HistoryListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 64,
        color: Colors.white,
      ),
    );
  }
}
