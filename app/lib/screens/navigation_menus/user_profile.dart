import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_profile_controller.dart';
import '../auth/edit_profile.dart';
import '../auth/kyc_registraion.dart';
import '../auth/pin/change_pin.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final contoller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(contoller.title.value),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(profile),
                        radius: 60,
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Transform.translate(
                        offset: const Offset(200, 75),
                        child: const CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ],
                )),
            Text(contoller.fullName.value,
                style: appStyles(18, null, FontWeight.bold)),
            Text(
              'Rider',
              style: appStyles(18, null, FontWeight.w300),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () => Get.to(EditProfileScreen()),
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.person_2,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('Edit Profile',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: () => Get.to(ChangePinScreen()),
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.lock,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('Change PIN',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: null,
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.work_history_rounded,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('History',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: () => Get.to(KycRegistrationScreen()),
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.error,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('KYC Registration',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: null,
                child: ListTile(
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.qr_code_2_rounded,
                    size: 30,
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
                  contentPadding: EdgeInsets.zero,
                  title: Text('QR Code',
                      style: appStyles(18, null, FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
