import 'package:app/controllers/rider/bloc/user_controller.dart';
import 'package:app/screens/rider/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/services/requests/rider/post_requests/choose_pin_request.dart';
import 'package:app/shareds/enums/user_type.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../screens/fleet_manager/navigation_menus/home_landing_tab_screen.dart';

class ConfirmPinController extends GetxController {
  RxString pin = ''.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController codeOneController = TextEditingController();
  TextEditingController codeTwoController = TextEditingController();
  TextEditingController codeThreeController = TextEditingController();
  TextEditingController codeFourController = TextEditingController();
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  final isLoaded = false.obs;
  GetSessionManager getSession = GetSessionManager();

  @override
  void onInit() {
    isLoaded.value = false;
    super.onInit();
  }

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  void updatePin(String value, int i) {
    if (pin.value.length < 4) {
      pin.value += value;
      if (pin.value.length < 4) {
        focusNodes[pin.value.length].requestFocus();
      }
    }
  }

  void deletePin() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  void deleteDigit(int index) {
    if (index >= 0 && index < pin.value.length) {
      pin.value =
          pin.value.substring(0, index) + pin.value.substring(index + 1);
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  Future<void> choosePin(String chosenPin) async {
    isLoaded.value = true;
    try {
      int userId = session.readUserId() as int;
      var response = await userController.choosePinAsync(ChoosePinRequest(
        pin: chosenPin,
        userId: userId,
        confirmPin: pin.value,
      ));
      if (response.status) {
        var userType = getSession.readUserType();
        if (userType == UserType.rider) {
          Get.offAll(() => const HomeLandingTabScreen());
        }
        if (userType == UserType.fleetManager) {
          Get.offAll(() => const FleetManagerHomeLandingTabScreen());
        }
      } else {
        Get.defaultDialog(
          title: 'Information',
          content: Text(response.message),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoaded.value = false;
    }
  }

  void validatePinAndCreate(String chosenPin) {
    pin.value =
        '${codeOneController.text}${codeTwoController.text}${codeThreeController.text}${codeFourController.text}';
    if (pin.value.length == 4) {
      if (pin.value != chosenPin) {
        showErrorSnackbar('PINs do not match.');
      } else {
        choosePin(chosenPin);
      }
    } else {
      showErrorSnackbar('Please enter a complete PIN.');
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}
