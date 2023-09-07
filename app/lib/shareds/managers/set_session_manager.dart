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

  writeIsUserLoggedIn(bool loggedIn) {
    storage.write(userLoggedIn, loggedIn);
  }
}
