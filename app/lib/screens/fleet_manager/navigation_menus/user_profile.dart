// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/rider/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: background,
        title: Text(
          controller.title.value,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Text("Hello Fleet Manager profile is here"),
          ),
        ],
      ),
    );
  }
}

