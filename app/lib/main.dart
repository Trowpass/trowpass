import 'package:app/screens/splash_screen.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FlutterError.onError = (errorDetails) {
//     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
//   };
//   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
//   PlatformDispatcher.instance.onError = (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//     return true;
//   };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final store = GetSessionManager();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // initialRoute: getInitialPage(),
      // getPages: AppPages.list,
      title: 'Trowpass',
    );
  }
}
