import 'package:app/screens/auth/pin/confirm_pin_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChoosePinController extends GetxController {
  RxString pin = ''.obs;
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  void updatePin(String value) {
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

  void navigateToConfirmPin() {
    if (pin.value.length == 4) {
      Get.to(ConfirmPinScreen(), arguments: pin.value);
    } else {
      showErrorSnackbar('Please enter a complete PIN.');
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}


