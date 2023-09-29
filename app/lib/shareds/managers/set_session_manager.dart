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
    storage.erase();
    writeIsUserOnBoarded(true);
  }

  void writeUserAccountBalance(double value) {
    storage.write(userAccountBalance, value);
  }

  void writeUserVirtualCardCreation(String value) {
    storage.write(virtualCardCreation, value);
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

  void writeBanks(dynamic value) {
    storage.write(banks, value);
  }
}
