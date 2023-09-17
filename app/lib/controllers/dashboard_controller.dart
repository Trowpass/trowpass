// ignore_for_file: avoid_print, unnecessary_string_interpolations
import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:app/widgets/currency_format.dart';
import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';
import '../widgets/app_dialog.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');
  final fullName = Rx<String>('');
  final accountNumber = Rx<String>('');
  final bankName = Rx<String>('');
  final phoneNumber = Rx<String>('');
  final balance = Rx<String>('');
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);

  GetSessionManager session = GetSessionManager();
  SetSessionManager session2 = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = true;
    fullName.value = session.readRiderFullName() ?? '';
    balance.value = formatCurrency(session.readUserAccountBalance() ?? 0.0);
    bankName.value = session.readUserBankName() ?? '';
    accountNumber.value = session.readUserAccountNumber() ?? '';
    phoneNumber.value = '';
    userProfile();
    userWallet();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  Future userProfile() async {
    var response = await userController.userProfileAsync();
    if (response.status) {
      var fullName2 = '${response.data!.firstName.toTitleCase()} ${response.data!.lastName.toCapitalized()}';
      session2.writeUserFullName(fullName2);
      fullName.value = fullName2;
    }
  }

  Future userWallet() async {
    var response = await userController.userWalletAsync();
    if (response.status) {
      accountNumber.value = response.data!.accountNumber;
      bankName.value = response.data!.bankName;
      phoneNumber.value = response.data!.phoneNumber;
      double balance1 = response.data!.balance;
      balance.value = formatCurrency(balance1);
      // save bank and account number for use later
      session2.writeUserAccountNumber(accountNumber.value);
      session2.writeUserAccountBalance(balance1);
      session2.writeUserBankName(bankName.value);
    }
  }

  Future<dynamic> displayPlaceholderDialog(String pageTitle) {
    return showAppDialog(
      title: pageTitle,
      subtitle: 'We have you in mind. In the main time, explore the available features. Thank you.',
      type: DialogType.warning,
    );
  }
}
