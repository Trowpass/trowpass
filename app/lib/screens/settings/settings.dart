import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_styles.dart';
import '../profile/change_password.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: null,
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.person_2,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: Text('Account',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => Get.to(ChangePasswordScreen()),
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.key_outlined,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('Change Password',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
