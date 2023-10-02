import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/resources/routes/app_pages.dart';
import 'package:app/shareds/resources/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
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
      getPages: AppPages.list,
      title: 'Trowpass',
    );
  }

  String getInitialPage() {
    String route = '';
    final isUserOnBoarded = store.readIsUserOnBoarded();
    final isUserLoggedIn = store.readIsUserLoggedIn();
    final isTokenExpired = store.readIsTokenExpired();
    final rememberMe = store.readShouldRememberMe();

    if(!isUserOnBoarded){
      route = AppRoutes.onboarding;
    }else{     
      if(!isUserLoggedIn){
        route = AppRoutes.login;
      }else if(isUserLoggedIn && rememberMe && isTokenExpired){
         route = AppRoutes.dashboard;
      }else if(isUserLoggedIn && !rememberMe && isTokenExpired){
         route = AppRoutes.login;
        }
        else{
          route = AppRoutes.dashboard;
      }
    }
    return route;
  }
}
