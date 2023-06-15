import 'package:get/get.dart';

class BeneficiariesController extends GetxController {
  final title = Rx<String>('Beneficiaries');
  final beneficiaryName = Rx<String>('');
  final beneficiaryFirstName = Rx<String>('Damilola');
  final beneficiaryLastName = Rx<String>('Funke');
  final nameAbbreviation = Rx<String>('');
  final accountNumber = Rx<String>('');

  String getNameAbbreviation() {
    String fnPrefix = beneficiaryFirstName.value.substring(0, 1);
    String lnPrefix = beneficiaryLastName.value.substring(0, 1);

    return '$fnPrefix$lnPrefix';
  }

  @override
  void onInit() {
    beneficiaryName.value =
        '${beneficiaryFirstName.value} ${beneficiaryLastName.value}';
    accountNumber.value = '03939833083';
    nameAbbreviation.value = getNameAbbreviation();
    super.onInit();
  }
}
