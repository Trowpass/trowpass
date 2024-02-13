import 'package:app/screens/auth/pin/confirm_pin_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChoosePinController extends GetxController {
  RxString pin = ''.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController codeOneController = TextEditingController();
  TextEditingController codeTwoController = TextEditingController();
  TextEditingController codeThreeController = TextEditingController();
  TextEditingController codeFourController = TextEditingController();

  void navigateToConfirmPin() {
    pin.value =
        '${codeOneController.text}${codeTwoController.text}${codeThreeController.text}${codeFourController.text}';
    if (pin.value.length == 4) {
      Get.offAll(ConfirmPinScreen(), arguments: pin.value);
    } else {
      showErrorSnackbar('Please enter a complete PIN.');
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}
