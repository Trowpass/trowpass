import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Color color;

  const Header({
    Key? key,
    required this.title,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: appStyles(18, Colors.black, FontWeight.bold),
      ),
    );
  }
}
