import 'package:get_storage/get_storage.dart';

import '../constants/session_constants.dart';

//For storing session data
class SetSessionManager {
  final storage = GetStorage();

  void writeRiderPhoneNumber(dynamic phoneNumber) {
    storage.write(riderMobilePhone, phoneNumber);
  }

  void writeRiderEmail(dynamic email) {
    storage.write(riderEmail, email);
  }

  void writeAuthorizationToken(dynamic token) {
    storage.write(authorizationToken, token);
  }

  void writeUserId(dynamic userId) {
    storage.write(userIdKey, userId);
  }

  void writeUserFirstName(dynamic fullName) {
    storage.write(userFirstName, fullName);
  }

  void writeUserFullName(dynamic fullName) {
    storage.write(riderFullName, fullName);
  }

  void writeIsUserOnBoarded(bool onBoarded) {
    storage.write(userOnBoarded, onBoarded);
  }

  void writeIsUserLoggedIn(bool loggedIn) {
    storage.write(userLoggedIn, loggedIn);
  }

  void writeUserAccountNumber(String value) {
    storage.write(userAccountNumber, value);
  }

  void writeUserBankName(String value) {
    storage.write(userBankName, value);
  }

  void logoutUser() {
    writeIsUserOnBoarded(true);
  }

  void writeUserAccountBalance(double value) {
    storage.write(userAccountBalance, value);
  }

  void writeVirtualCardPan(String value) {
    storage.write(virtualCardPan, value);
  }

  void writeVirtualCardExpiration(String value) {
    storage.write(virtualCardExpiration, value);
  }

  void writeVirtualCardCVV(String value) {
    storage.write(virtualCardCVV, value);
  }

  void writeVirtualCardType(String value) {
    storage.write(virtualCardType, value);
  }

  void writeVirtualCardBalance(double value) {
    storage.write(virtualCardBalance, value);
  }

  void writePinCreated(bool value) {
    storage.write(pinCreated, value);
  }

  void writeWalletCreated(bool value) {
    storage.write(walletCreated, value);
  }

  void writeAllBanks(String key, List<String> value) {
    storage.writeIfNull(key, value);
  }

  void writeSelectedBankName(String key, String value) {
    storage.writeIfNull(key, value);
  }

  void writeBankIdMap(String key, Map<String, int> value) {
    storage.writeIfNull(key, value);
  }

  void writebankCodeMap(String key, Map<String, String> value) {
    storage.writeIfNull(key, value);
  }

  void writeAllTransportCompanies(String key, List<String> value) {
    storage.writeIfNull(key, value);
  }

  void writeSelectedTransportCompanies(String key, String value) {
    storage.writeIfNull(key, value);
  }

  void writeTransportCompanyIdMap(String key, Map<String, int> value) {
    storage.writeIfNull(key, value);
  }

  void writeVirtualCardCreated(bool value) {
    storage.write(walletCreated, value);
  }

  void writeAccountType(String value) {
    storage.write(accountType, value);
  }

  void writeTokenExpiration(DateTime? tokenExpires) {
    storage.write(tokenExpiration, tokenExpires);
  }

  void writeShouldRememberMe(bool loggedIn) {
    storage.write(shouldRememberMe, loggedIn);
  }

  void writeResetPasswordToken(String value) {
    storage.write(resetPasswordToken, value);
  }

  void writeQRCode(String value) {
    storage.write(qrCode, value);
  }

  void setIsProfilePictureInfoShown(bool value) {
    storage.write(profilePictureInfoShown, value);
  }

  void writeProfileBioData(String value) {
    storage.write(profileBioData, value);
  }

  void writeProfileBvn(String value) {
    storage.write(profileBvn, value);
  }

  void writeProfileStreet(String value) {
    storage.write(profileStreet, value);
  }

  void writeProfileCity(String value) {
    storage.write(profileCity, value);
  }

  void writeProfileCountry(String value) {
    storage.write(profileCountry, value);
  }

  void writeProfileState(String value) {
    storage.write(profileState, value);
  }

  void writeProfilePostalCode(String value) {
    storage.write(profilePostalCode, value);
  }

  void writeProfileFN(String value) {
    storage.write(profileFN, value);
  }

  void writeProfileLN(String value) {
    storage.write(profileLN, value);
  }

  void writeProfilePN(String value) {
    storage.write(profilePN, value);
  }
}
