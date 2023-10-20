import 'package:get_storage/get_storage.dart';

import '../constants/session_constants.dart';

//For getting session data
class GetSessionManager {
  final storage = GetStorage();

  String? readRiderPhoneNumber() => storage.read(riderMobilePhone);
  String? readRiderEmail() => storage.read(riderEmail);
  String? readAuthorizationToken() => storage.read(authorizationToken);
  int? readUserId() => storage.read(userIdKey);
  String? readUserFirstName() => storage.read(userFirstName);
  String? readRiderFullName() => storage.read(riderFullName);
  bool readIsUserLoggedIn() => storage.read(userLoggedIn) ?? false;
  bool readIsUserOnBoarded() => storage.read(userOnBoarded) ?? false;
  String? readUserBankName() => storage.read(userBankName);
  String? readUserAccountNumber() => storage.read(userAccountNumber);
  double? readUserAccountBalance() => storage.read(userAccountBalance);
  String? readVirtualCardPan() => storage.read(virtualCardPan);
  String? readVirtualCardExpiration() => storage.read(virtualCardExpiration);
  String? readVirtualCardCVV() => storage.read(virtualCardCVV);
  double? readVirtualCardBalance() => storage.read(virtualCardBalance);
  String? readVirtualCardType() => storage.read(virtualCardType);
  bool readPinCreated() => storage.read(pinCreated) ?? false;
  bool readWalletCreated() => storage.read(walletCreated) ?? false;
  List<String> readAllBanks(String key) =>
      (storage.read(key) as List<dynamic>?)?.cast<String>() ?? [];
  String? readSelectedBankName(String key) => storage.read(key);
  Map<String, int> readBankIdMap(String key) =>
      (storage.read(key) as Map<dynamic, dynamic>?)?.cast<String, int>() ?? {};
  Map<String, String> readbankCodeMap(String key) =>
      (storage.read(key) as Map<dynamic, dynamic>?)?.cast<String, String>() ??
      {};
  //transport
  List<String> readAllTransportCompanies(String key) =>
      (storage.read(key) as List<dynamic>?)?.cast<String>() ?? [];
  String? readSelectedTransportCompanies(String key) => storage.read(key);
  Map<String, int> readTransportCompanyIdMap(String key) =>
      (storage.read(key) as Map<dynamic, dynamic>?)?.cast<String, int>() ?? {};
  bool readVirtualCardCreated() => storage.read(virtualCardCreated) ?? false;
  String readAccountType() => storage.read(accountType) ?? '';
  DateTime readTokenExpires() =>
      storage.read(tokenExpiration) ?? DateTime.now();
  bool readShouldRememberMe() => storage.read(shouldRememberMe) ?? false;
  String readResetPasswordToken() => storage.read(resetPasswordToken);
  String readQRCode() => storage.read(qrCode);
  bool readProfilePictureInfoShown() =>
      storage.read(profilePictureInfoShown) ?? false;
  String readProfilePostalCode() => storage.read(profilePostalCode) ?? '';
  String readProfileBioData() => storage.read(profileBioData) ?? '';
  String readProfileBvn() => storage.read(profileBvn) ?? '';
  String readProfileCity() => storage.read(profileCity) ?? '';
  String readProfileCountry() => storage.read(profileCountry) ?? '';
  String readProfileFN() => storage.read(profileFN) ?? '';
  String readProfileLN() => storage.read(profileLN) ?? '';
  String readProfilePN() => storage.read(profilePN) ?? '';
  String readProfileState() => storage.read(profileState) ?? '';
  String readProfileStreet() => storage.read(profileStreet) ?? '';

  bool readIsTokenExpired() {
    try {
      return DateTime.now().isAfter(readTokenExpires());
    } catch (err) {
      return true;
    }
  }
}
