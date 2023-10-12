import 'package:app/screens/kyc/tier_1_account_upgrade.dart';
import 'package:app/shareds/constants/key_constants.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TierSelectionPage extends StatelessWidget {
  const TierSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isT1Done = false;
    bool isT2Done = false;
    bool isT3Done = false;
    bool isDefault = false;
    GetSessionManager session = GetSessionManager();
    String accountType = session.readAccountType();
    if (accountType == t1Account) {
      isT1Done = true;
    } else if (accountType == t2Account) {
      isT2Done = true;
    } else if (accountType == t3Account) {
      isT3Done = true;
    } else {
      isDefault = true;
    }
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
          elevation: 0.0,
          backgroundColor: background,
          title: Text('KYC Verification',
              style: appStyles(18, titleActive, FontWeight.w600)),
          centerTitle: true,
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Upgrade your account to enjoy the boundless benefits we have for you!!',
                textAlign: TextAlign.center,
                style: appStyles(18, null, FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  style: isT1Done == false
                      ? null
                      : OutlinedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[100],
                          foregroundColor: offWhite),
                  onPressed: () {
                    isT1Done == true
                        ? null
                        : Get.to(() => const TeirOneAccountUpgradeScreen());
                  },
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.perm_identity_outlined,
                      color: gray,
                    ),
                    title: Text(
                      'Tier 1 Account Upgrade',
                      style: appStyles(18, gray, FontWeight.bold),
                    ),
                    trailing: isT1Done == false
                        ? null
                        : const Icon(
                            Icons.check_circle_rounded,
                            color: successColor,
                          ),
                  )),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  style: isT2Done == false
                      ? null
                      : OutlinedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[100],
                          foregroundColor: offWhite),
                  onPressed: isDefault == true
                      ? null
                      : () {
                          isT2Done == true
                              ? null
                              : null; //Get.to(() => const TeirTwoAccountUpgradeScreen())
                        },
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.perm_identity_outlined,
                      color: gray,
                    ),
                    title: Text(
                      'Tier 2 Account Upgrade',
                      style: appStyles(18, gray, FontWeight.bold),
                    ),
                    trailing: isT2Done == false
                        ? null
                        : const Icon(
                            Icons.check_circle_rounded,
                            color: successColor,
                          ),
                  )),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  style: isT3Done == false
                      ? null
                      : OutlinedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[100],
                          foregroundColor: offWhite),
                  onPressed: isDefault == true
                      ? null
                      : () {
                          isT3Done == true
                              ? null
                              : null; //Get.to(() => const TeirThreeAccountUpgradeScreen())
                        },
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.perm_identity_outlined,
                      color: gray,
                    ),
                    title: Text(
                      'Tier 3 Account Upgrade',
                      style: appStyles(18, gray, FontWeight.bold),
                    ),
                    trailing: isT3Done == false
                        ? null
                        : const Icon(
                            Icons.check_circle_rounded,
                            color: successColor,
                          ),
                  ))
            ],
          ),
        ));
  }
}
