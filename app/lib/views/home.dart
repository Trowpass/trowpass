import 'package:app/widgets/side_nav_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(title: Text('Test home'), centerTitle: true),
      body: Center(
        child: Text('Testing home'),
      ),
    );
  }
}
