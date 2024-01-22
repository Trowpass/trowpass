import 'package:app/screens/kyc/tier_upgrade_selection.dart';
import 'package:app/screens/send_money/scan_to_pay/qr_code.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/user_profile_controller.dart';
import '../../shareds/utils/border_radius.dart';
import '../auth/edit_profile.dart';
import '../auth/pin/change_pin.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    double imageSize = 120;

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
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: background,
        title: Text(
          controller.title.value,
          style: const TextStyle(color: Colors.black),
        ),
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
                    alignment: Alignment.center,
                    children: [
                      Obx(() => Stack(
                            alignment: Alignment.center,
                            children: [
                              Visibility(
                                visible: controller.profileImage.value.isEmpty,
                                child: Placeholder(imageSize: imageSize),
                              ),
                              CachedNetworkImage(
                                width: imageSize,
                                height: imageSize,
                                imageUrl: controller.profileImage.value,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: imageSize,
                                  height: imageSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) {
                                  return const CircularProgressIndicator();
                                },
                                errorWidget: (context, url, error) =>
                                    Placeholder(imageSize: imageSize),
                              ),
                              Visibility(
                                visible: controller.isLoading.value,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: Material(
                          borderRadius: BorderRadius.circular(200),
                          color: primaryColor.withOpacity(0.9),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            splashColor: primaryColor.withOpacity(0.5),
                            onTap: () => controller.uploadImage(),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Text(controller.fullName.value,
                  style: appStyles(18, null, FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'Rider',
                style: appStyles(18, null, FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onTap: () => Get.to(() => EditProfileScreen()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Image.asset(userEdit),
                      trailing:
                          const Icon(Icons.keyboard_arrow_right, size: 24),
                      contentPadding: EdgeInsets.zero,
                      title: Text('Edit Profile',
                          style: appStyles(18, null, FontWeight.w500)),
                    ),
                  ),
                ),
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onTap: () => Get.to(ChangePinScreen()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Image.asset(lock),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 24),
                    contentPadding: EdgeInsets.zero,
                    title: Text('Change PIN',
                        style: appStyles(18, null, FontWeight.w500)),
                  ),
                ),
              ),
              // InkWell(
              //   customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //   onTap: () {},
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8),
              //     child: ListTile(
              //       horizontalTitleGap: 0,
              //       leading: SvgPicture.asset(
              //         history,
              //         width: 28,
              //         height: 28,
              //         colorFilter: const ColorFilter.mode(label, BlendMode.srcIn),
              //       ),
              //       trailing: const Icon(Icons.keyboard_arrow_right, size: 24),
              //       contentPadding: EdgeInsets.zero,
              //       title: Text('History', style: appStyles(18, null, FontWeight.w500)),
              //     ),
              //   ),
              // ),
              Visibility(
                visible: controller.kycRegistrationText.value.isNotEmpty,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onTap: () => Get.to(() => const TierSelectionPage()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Image.asset(scanBarcode),
                      trailing:
                          const Icon(Icons.keyboard_arrow_right, size: 24),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        controller.kycRegistrationText.value,
                        style: appStyles(18, null, FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onTap: () => Get.to(() => ScanScreen()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Image.asset(scanBlack),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 24),
                    contentPadding: EdgeInsets.zero,
                    title: Text('QR Code',
                        style: appStyles(18, null, FontWeight.w500)),
                  ),
                ),
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onTap: () => Get.to(() => ScanScreen()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.auto_delete_outlined,
                      size: 30,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 24),
                    contentPadding: EdgeInsets.zero,
                    title: Text('Delete Account',
                        style: appStyles(18, null, FontWeight.w500)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.logout(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius)),
                        side: const BorderSide(
                          color:
                              primaryColor, // Apply border color or transparent if not provided
                        ),
                        backgroundColor: background,
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      icon: Image.asset(logout),
                      label: Text(
                        'Logout',
                        style: appStyles(16, Colors.black, FontWeight.w400),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  const Placeholder({
    super.key,
    required this.imageSize,
  });

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        person,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
