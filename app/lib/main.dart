import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/resources/routes/app_pages.dart';
import 'package:app/shareds/resources/routes/app_reoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = GetSessionManager();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialPage(),
      // initialRoute: AppRoutes.test,
      getPages: AppPages.list,
      title: 'Trowpass',
    );
  }

  String getInitialPage() {
    final isUserOnBoarded = store.readIsUserOnBoarded();
    final isUserLoggedIn = store.readIsUserLoggedIn();

    if (isUserOnBoarded && !isUserLoggedIn) {
      return AppRoutes.login;
    } else if (isUserOnBoarded && isUserLoggedIn) {
      return AppRoutes.dashboard;
    } else {
      return AppRoutes.onboarding;
    }
  }
}
