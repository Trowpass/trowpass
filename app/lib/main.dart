import 'package:app/screens/auth/account_type_screen.dart';
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
      title: 'Trowpass',
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: primaryColor,
      //   colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      //   useMaterial3: true,
      // ),
      home: AccountTypeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      

//         );
//   }
// }
