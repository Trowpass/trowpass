// ignore_for_file: avoid_print, unnecessary_string_interpolations, avoid_function_literals_in_foreach_calls
import 'package:app/controllers/bloc/topup_transport_wallet_controller.dart';
import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/dashboard/dashboard.dart';
import 'package:app/services/requests/post_requests/create_wallet_request.dart';
import 'package:app/services/responses/get_all_banks_reponse.dart';
import 'package:app/services/responses/get_all_transport_company_response.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/pin/choose_pin_screen.dart';
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
  final isLoaded = false.obs;
  final isWalletCreated = false.obs;
  final walletCreateLoader = false.obs;
  RxDouble sliderValue = 0.0.obs;
  final double slideWidth = 200.0;
  final selectedTransportCompany = 'Select company'.obs;
  final selectedBankName = 'Select bank'.obs;
  final TopupTransportWalletController topupTransportWalletController =
      TopupTransportWalletController();

  void onSlideChanged(double value) {
    sliderValue.value = value;
  }

  GetSessionManager session = GetSessionManager();
  SetSessionManager session2 = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = true;
    isWalletCreated.value = false;
    fullName.value = session.readRiderFullName() ?? '';
    balance.value = formatCurrency(session.readUserAccountBalance() ?? 0.0);
    bankName.value = session.readUserBankName() ?? '';
    accountNumber.value = session.readUserAccountNumber() ?? '';
    phoneNumber.value = '';
    userProfile();
    userWallet();
    fetchBanks();
    fetchTransportCompany();
    printSessionStorageContents();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  void onSetSelectedTransportCompany(Object? value) {
    selectedTransportCompany.value = value.toString();
  }

  void onSetSelectedBankName(Object? value) {
    selectedBankName.value = value.toString();
  }

  List<String> allBanks = [];
  List<String> allTransportCompany = [];
  List<String> allBankNames = [];
  Map<String, int> bankIdMap = {};
  Map<String, String> bankCodeMap = {};
  Map<String, int> transportCompanyIdMap = {};

  void fetchBanks() async {
    try {
      BanksResponse banksResponse =
          await topupTransportWalletController.getallBanksAsync();
      if (banksResponse.status) {
        List<ResponseData> banksData = banksResponse.data;
        List<String> bankNamesList = ['Select bank'];
        banksData.forEach((bank) {
          String bankName = bank.bankName;
          int bankId = bank.id;
          String bankCode = bank.bankCode;
          bankIdMap[bankName] = bankId;
          bankCodeMap[bankName] = bankCode;
          bankNamesList.add('$bankName');
        });
        allBanks = bankNamesList;
        selectedBankName.value = bankNamesList[0];

        // Save banks to session storage
        session2.writeAllBanks('allBanks', allBanks);
        session2.writeSelectedBankName(
            'selectedBankName', selectedBankName.value);
        session2.writeBankIdMap('bankIdMap', bankIdMap);
        session2.writebankCodeMap('bankCodeMap', bankCodeMap);
      }
    } catch (e) {
      print('Error fetching banks: $e');
    }
  }

  void fetchTransportCompany() async {
    try {
      TransportCompanyResponse transportCompanyResponse =
          await topupTransportWalletController.getallTransportCompanyAsync();
      if (transportCompanyResponse.status) {
        List<TransportCompanyResponseData> transportCompanyData =
            transportCompanyResponse.data;
        List<String> transportCompaniesList = ['Select company'];
        transportCompanyData.forEach((company) {
          String name = company.name;
          int transportId = company.id;
          transportCompanyIdMap[name] = transportId;
          transportCompaniesList.add('$name');
        });
        // transportCompaniesList.addAll(transportCompanyData.map((company) {
        //   transportCompanyIdMap[company.name] = company.id;
        //   return company.name;
        // }));
        allTransportCompany = transportCompaniesList;
        selectedTransportCompany.value = transportCompaniesList[0];

        // Save transport companies details to session storage
        session2.writeAllTransportCompanies(
            'allTransportCompanies', allTransportCompany);
        session2.writeSelectedTransportCompanies(
            'selectedTransportCompany', selectedTransportCompany.value);
        session2.writeTransportCompanyIdMap(
            'transportCompanyIdMap', transportCompanyIdMap);
      }
    } catch (e) {
      print('Error fetching banks: $e');
    }
  }

  void printSessionStorageContents() {
    final Map<String, dynamic> allData = {};
    final allKeys = session.storage.getKeys();

    for (var key in allKeys) {
      allData[key] = session.storage.read(key);
    }

    print('Session Storage Contents:');
    allData.forEach((key, value) {
      print('$key: $value');
    });
  }

  Future userProfile() async {
    var response = await userController.userProfileAsync();
    if (response.status) {
      var fullName2 =
          '${response.data!.firstName.toTitleCase()} ${response.data!.lastName.toCapitalized()}';
      fullName.value = fullName2;
      session2.writeUserFullName(fullName2);
      session2.writeAccountType(response.data!.accountType);
      isWalletCreated.value =
          response.data != null ? response.data!.isWalletCreated : false;
      qrCodeUrl.value = response.data!.qr!;
      //for profile
      if (response.data!.kycDetail != null) {
        session2
            .writeProfileBioData(response.data!.kycDetail!.address!.bioData!);
        session2.writeProfileBvn(response.data!.kycDetail!.bvn!);
        session2.writeProfileCity(response.data!.kycDetail!.address!.city!);
        session2
            .writeProfileCountry(response.data!.kycDetail!.address!.country!);
        session2.writeProfileState(response.data!.kycDetail!.address!.state!);
        session2.writeProfileStreet(response.data!.kycDetail!.address!.street!);
        session2.writeProfilePostalCode(
            response.data!.kycDetail!.address!.postalCode!);
        session2.writeProfileFN(response.data!.firstName);
        session2.writeProfileLN(response.data!.lastName);
        session2.writeProfilePN(response.data!.phoneNumber);
      }
      if (!response.data!.isPinCreated) {
        Get.to(() => ChoosePinScreen());
      }
    }
  }

  Future userWallet() async {
    var response = await userController.userWalletAsync();
    if (response.status) {
      accountNumber.value = response.data?.accountNumber ?? '';
      bankName.value = response.data?.bankName! ?? '';
      phoneNumber.value = response.data?.phoneNumber ?? '';
      double balance1 = response.data?.balance ?? 0.0;
      balance.value = formatCurrency(balance1);
      session2.writeUserAccountNumber(accountNumber.value);
      session2.writeUserAccountBalance(balance1);
      session2.writeUserBankName(bankName.value);
    } else {
      Get.snackbar('Information', 'Please create account',
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      walletCreateLoader.value = false;
    }
  }

  Future createWallet() async {
    walletCreateLoader.value = true;
    try {
      int userId = session.readUserId() ?? 0;
      var response = await userController
          .createWalletAsync(CreateWalletRequest(userId: userId));
      if (response.status) {
        Get.offAll(() => DashboardScreen());
        walletCreateLoader.value = false;
      } else {
        Get.defaultDialog(
            title: 'Information', content: Text(response.message));
        walletCreateLoader.value = false;
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      walletCreateLoader.value = false;
    }
  }

  Future<dynamic> displayPlaceholderDialog(String pageTitle) {
    return placeholderDialog(pageTitle);
  }
}
