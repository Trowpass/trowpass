import 'package:app/shareds/resources/routes/app_pages.dart';
import 'package:app/shareds/resources/routes/app_reoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppPages.list,
      title: 'Trowpass',
    );
  }
}
