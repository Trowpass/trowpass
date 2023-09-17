import 'package:app/controllers/bloc/user_controller.dart';
import 'package:get/get.dart';

class CardsTabController extends GetxController {
  final isLoading = true.obs;
  final isVirtualCardCreated = false.obs;
  final userController = UserController();

  @override
  void onInit() {
    super.onInit();
    setInitialScreen();
  }

  Future<void> setInitialScreen() async {
    isLoading.value = true;
    var response = await userController.userProfileAsync();
    if (response.status && response.data != null) {
      isVirtualCardCreated.value = response.data!.isVirtualCardCreated;
    }
    isLoading.value = false;
  }
}
