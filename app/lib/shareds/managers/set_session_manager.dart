import 'package:get_storage/get_storage.dart';

import '../constants/session_constants.dart';

//For storing session data
class SetSessionManager {
  final storage = GetStorage();

  void writeRiderPhoneNumber(dynamic riderMobile) {
    storage.write(riderMobilePhone, riderMobile);
  }

  void writeRiderEmail(dynamic email) {
    storage.write(riderEmail, email);
  }

  void writeAuthorizationToken(dynamic token) {
    storage.write(authorizationToken, token);
  }

  void writeUserFirstName(dynamic fn) {
    storage.write(userFirstName, fn);
  }
}
