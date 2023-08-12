import 'package:get_storage/get_storage.dart';

import '../constants/session_constants.dart';

//For getting session data
class GetSessionManager {
  final storage = GetStorage();

  String? readRiderPhoneNumber() => storage.read(riderMobilePhone);
  String? readRiderEmail() => storage.read(riderEmail);
  String? readAuthorizationToken() => storage.read(authorizationToken);
  String? readUserId() => storage.read(userIdKey);
  String? readUserFirstName() => storage.read(userFirstName);
  String? readRiderFullName() => storage.read(riderFullName);
}
