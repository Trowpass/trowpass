import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/screens/kyc/tier_1_account_upgrade.dart';
import 'package:app/services/requests/put_requests/update_customer_data_request.dart';
import 'package:app/shareds/constants/dropdown_constants.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycUpgradeAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  List<dynamic> country = ['Select', 'Nigeria'];
  final selectedCountry = 'Select'.obs;

  List<String> states = nigeriaStates;
  final selectedState = 'Select'.obs;

  final isLoaded = false.obs;

  UserController userController = UserController();
  GetSessionManager session = GetSessionManager();
  SetSessionManager setSession = SetSessionManager();

  @override
  void onInit() async {
    isLoaded.value = false;
    //get profile details
    bioController.text = session.readProfileBioData();
    bvnController.text = session.readProfileBvn();
    firstNameController.text = session.readProfileFN();
    lastNameController.text = session.readProfileLN();
    postalCodeController.text = session.readProfilePostalCode();
    stateController.text = session.readProfileState();
    cityController.text = session.readProfileCity();
    phoneNumberController.text = session.readProfilePN();
    streetAddressController.text = session.readProfileStreet();
    selectedCountry.value = session.readProfileCountry() == ''
        ? 'Select'
        : session.readProfileCountry();
    selectedState.value = session.readProfileState() == ''
        ? country[0]
        : session.readProfileState();
    super.onInit();
  }

  void onSetSelectedCountry(Object? value) {
    selectedCountry.value = value.toString();
  }

  void onSetSelectedState(Object? value) {
    selectedState.value = value.toString();
  }

  Future updateProfile(BuildContext context) async {
    try {
      isLoaded.value = true;
      var response = await userController.updateCustomerDataAsync(
          UpdateCustomerDataRequest(
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              phoneNumber: phoneNumberController.text.trim(),
              bio: bioController.text.trim(),
              bvn: bvnController.text.trim(),
              address: UpdateCustomerDataAddress(
                  city: cityController.text.trim(),
                  street: streetAddressController.text.trim(),
                  postalCode: postalCodeController.text.trim(),
                  country: selectedCountry.value.trim(),
                  state: selectedState.value.trim())));
      if (response.status) {
        setSession.writeProfileBioData(bioController.text.trim());
        setSession.writeProfileBvn(bvnController.text.trim());
        setSession.writeProfileCity(cityController.text.trim());
        setSession.writeProfileCountry(selectedCountry.value.trim());
        setSession.writeProfileState(selectedState.value.trim());
        setSession.writeProfileStreet(streetAddressController.text.trim());
        setSession.writeProfilePostalCode(postalCodeController.text.trim());
        setSession.writeProfileFN(firstNameController.text.trim());
        setSession.writeProfileLN(lastNameController.text.trim());
        setSession.writeProfilePN(phoneNumberController.text.trim());
        Get.to(() => const TeirOneAccountUpgradeScreen());
        isLoaded.value = false;
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
}
