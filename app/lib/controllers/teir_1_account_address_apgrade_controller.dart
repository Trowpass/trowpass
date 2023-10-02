import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/services/requests/put_requests/tier_one_request.dart';
import 'package:app/shareds/constants/dropdown_constants.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeirOneAccountAddressUpgradeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  final birthPlace = ''.obs;
  final dob = Rx<DateTime>(DateTime.now());
  final gender = ''.obs;
  final imagePath = ''.obs;
  final bvn = ''.obs;

  final isLoaded = false.obs;
  late Map<String, dynamic> upgradeDataArgs;

  List<dynamic> country = ['Select', 'Nigeria'];
  final selectedCountry = 'Select'.obs;

  List<String> states = nigeriaStates;
  final selectedState = 'Select'.obs;

  UserController userController = UserController();

  @override
  void onInit() async {
    isLoaded.value = false;
    upgradeDataArgs = Get.arguments;
    birthPlace.value = upgradeDataArgs['birth_place'];
    dob.value = upgradeDataArgs['d_o_b'];
    gender.value = upgradeDataArgs['gnd'];
    imagePath.value = upgradeDataArgs['file_path'];
    bvn.value = upgradeDataArgs['bvn'];
    super.onInit();
  }

  void onSetSelectedCountry(Object? value) {
    selectedCountry.value = value.toString();
  }

  void onSetSelectedState(Object? value) {
    selectedState.value = value.toString();
  }

  Future submitTierOneKycUpgrade(BuildContext context) async {
    try {
      isLoaded.value = true;
      var response = await userController.t1AccountUpgradeAsync(TierOneRequest(
          placeOfBirth: birthPlace.value.trim(),
          dateOfBirth: dob.value,
          gender: gender.value.trim(),
          bvn: bvn.value.trim(),
          address: T1Address(
              street: streetController.text.trim(),
              city: cityController.text.trim(),
              state: selectedState.value.trim(),
              country: selectedCountry.value.trim(),
              postalCode: postalCodeController.text.trim()),
          imagePath: imagePath.value.trim()));
      if (response.status) {
        isLoaded.value = false;
        Get.defaultDialog(
            onWillPop: () async => showExitPopup(context),
            barrierDismissible: false,
            titlePadding: const EdgeInsets.only(top: 15),
            contentPadding: const EdgeInsets.all(15),
            title: 'Account Upgrade',
            content: const Column(
              children: [
                Divider(),
                Text(
                    'Congratulations! Your account has been upgraded to Tier 1 account successfully.')
              ],
            ),
            confirm: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.login_outlined),
                onPressed: () => Get.offAll(() => LoginScreen()),
                label: const Text('Please Login to Continue'),
              ),
            ));
      } else {
        isLoaded.value = false;
        Get.snackbar('Information', response.message,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Action Required'),
            content: const Text(
                'You have a pending action to be completed. Do you want to close it?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: dialogInfoBackground),
                onPressed: () => Get.back(closeOverlays: false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
