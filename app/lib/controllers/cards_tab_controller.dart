import 'package:get/get.dart';

class CardsTabController extends GetxController {
  final title = ''.obs;
  final isLoading = false.obs;
  final shouldCreate = false.obs;
  bool get shouldShow => isLoading.value && shouldCreate.value;
}
