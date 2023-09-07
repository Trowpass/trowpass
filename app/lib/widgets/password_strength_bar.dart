import 'package:flutter/material.dart';
import '../shareds/utils/app_colors.dart';
import 'app_styles.dart';

enum Strength { weak, moderate, secure }

class PasswordStrengthBar extends StatelessWidget {
  final Strength strength;

  const PasswordStrengthBar({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 7,
                      width: constraints.maxWidth / 5,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 7,
                      width: constraints.maxWidth / 5,
                      decoration: BoxDecoration(
                        color: [Strength.moderate, Strength.secure].contains(strength) ? Colors.orange : greyLight,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 7,
                    width: constraints.maxWidth / 5,
                    decoration: BoxDecoration(
                      color: strength == Strength.secure ? Colors.green : greyLight,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                strength == Strength.weak ? 'Weak!' : (strength == Strength.moderate ? 'Okay!' : 'Strong!'),
                textAlign: TextAlign.right,
                style: appStyles(14, null, FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
