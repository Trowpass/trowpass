import 'package:flutter/material.dart';
import '../../../widgets/bottom_bar_navigation_menu.dart';
import 'bills_tab_screen.dart';
import 'history_tab_screen.dart';
import 'home_tab_screen.dart';
import 'user_profile.dart';

class HomeLandingTabScreen extends StatefulWidget {
  const HomeLandingTabScreen({super.key});

  @override
  State<HomeLandingTabScreen> createState() => _HomeLandingTabScreenState();
}

class _HomeLandingTabScreenState extends State<HomeLandingTabScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: [
          const HomeTabScreen(),
          const HistoryTabScreen(),
          const BillsTabScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationMenu(
        pageIndex,
        (index) => setState(() => pageIndex = index),
      ),
    );
  }
}
