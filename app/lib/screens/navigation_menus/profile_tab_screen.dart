import 'package:app/screens/auth/account_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_tab_controller.dart';
import '../../shareds/utils/app_colors.dart';

class ProfileTabScreen extends GetView<ProfileTabController> {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.title,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Profile Page",
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
                onPressed: () => Get.to(const AccountTypeScreen()),
                child: const Text('Move to another page'))
          ],
        ),
      ),
    );
  }
}
