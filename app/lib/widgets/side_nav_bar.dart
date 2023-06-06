import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/side_nav_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/login.dart';
import '../shareds/utils/images.dart';
import 'app_styles.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(logo),
                    )),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => Get.back(),
                          child: const Icon(
                            Icons.close_rounded,
                            color: background,
                          )),
                    ))
                  ],
                ),
                const Divider(),
                ListTile(
                  title: Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          logo,
                          fit: BoxFit.fill,
                          width: 90,
                          height: 110,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Kodex',
                    style: appStyles(17, background, FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
          sideNavBarItem(Icons.home_rounded, 'Dashboard', null, null),
          sideNavBarItem(Icons.work_history_rounded, 'History', null, null),
          sideNavBarItem(Icons.wallet_rounded, 'Wallet', null, null),
          sideNavBarItem(Icons.person_rounded, 'Account', null, null),
          sideNavBarItem(Icons.settings_rounded, 'Settings', null, null),
          const Divider(),
          sideNavBarItem(Icons.logout_rounded, 'Logout', null, logout),
        ],
      ),
    );
  }
}

void logout() {
  Get.offAll(const LoginScreen());
}
