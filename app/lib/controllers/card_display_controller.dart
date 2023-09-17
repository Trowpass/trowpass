import 'package:app/widgets/currency_format.dart';
import 'package:get/get.dart';

class CardDisplayController extends GetxController {
  final isLoading = false.obs;
  late final Rx<String> balance;

  @override
  void onInit() {
    super.onInit();
    balance.value = formatCurrency(0.0);
  }
}
