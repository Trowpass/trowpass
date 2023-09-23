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
  String? readUserVirtualCardCreation() => storage.read(virtualCardCreation);
  String? readVirtualCardPan() => storage.read(virtualCardPan);
  String? readVirtualCardExpiration() => storage.read(virtualCardExpiration);
  String? readVirtualCardCVV() => storage.read(virtualCardCVV);
  double? readVirtualCardBalance() => storage.read(virtualCardBalance);
  String? readVirtualCardType() => storage.read(virtualCardType);
}
