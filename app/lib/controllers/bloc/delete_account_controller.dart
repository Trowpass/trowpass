import 'package:app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  final userRepository = UserRepository();
  final isLoaded = false.obs;
  final selectedOption = ''.obs;
  final isChecked = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoaded.value = false;
    selectedOption.value = '0';
  }

  // Future<CreateVirtualCardResponse> deleteAccountAsync(
  //     CreateVirtualCardRequest request) async {
  //   try {
  //     final response = await cardRepository.createVirtualCardAsync(request);
  //     if (response.status) {
  //       return response;
  //     }
  //     return Future.error(response.message);
  //   } catch (e) {
  //     return Future.error('Unable to create card. Please try again!');
  //   }
  // }
}
