import 'package:app/widgets/bottom_bar_navigation_menu_fleet_manager.dart';
import 'package:flutter/material.dart';
import 'bills_tab_screen.dart';
import 'history_tab_screen.dart';
import 'home_tab_screen.dart';
import 'user_profile.dart';

class FleetManagerHomeLandingTabScreen extends StatefulWidget {
  const FleetManagerHomeLandingTabScreen({super.key});

  @override
  State<FleetManagerHomeLandingTabScreen> createState() => _FleetManagerHomeLandingTabScreenState();
}

class _FleetManagerHomeLandingTabScreenState extends State<FleetManagerHomeLandingTabScreen> {
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
