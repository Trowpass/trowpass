import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/services/requests/post_requests/choose_pin_request.dart';
import 'package:app/services/requests/post_requests/create_wallet_request.dart';
import 'package:app/services/requests/post_requests/re_create_wallet_request.dart';
import 'package:app/services/requests/post_requests/rider_registration_request.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/requests/post_requests/verify_otp_request.dart';
import 'package:app/services/requests/post_requests/view_user_by_phone_request.dart';
import 'package:app/services/responses/base_response.dart';
import 'package:app/services/responses/create_wallet_response.dart';
import 'package:app/services/responses/re_create_wallet_response.dart';
import 'package:app/services/responses/user_login_response.dart';
import 'package:app/services/responses/view_profile_response.dart';
import 'package:app/services/responses/view_user_by_phone_response.dart';
import 'package:app/services/responses/view_wallet_response.dart';
import 'package:app/shareds/managers/set_session_manager.dart';

import '../../services/responses/verify_account_response.dart';
import '../../shareds/managers/get_session_manager.dart';

class UserController {
  final UserRepository userRepository = UserRepository();
  final SetSessionManager session = SetSessionManager();
  final GetSessionManager getSession = GetSessionManager();

  Future<UserLoginResponse> loginAsync(UserLoginRequest request) async {
    try {
      final response = await userRepository.userLoginAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> riderRegistrationAsync(
      RiderRegistrationRequest request) async {
    try {
      final response = await userRepository.createRiderAccountAsync(request);
      if (response.status) {
        //store register user phone number
        session.writeRiderPhoneNumber(request.phoneNumber);
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<VerifyAccountResponse> verifyOtpAsync(VerifyOtpRequest request) async {
    try {
      var customerPhoneNumber = getSession.readRiderPhoneNumber();
      final response =
          await userRepository.verifyOtpAsync(request, customerPhoneNumber);
      if (response.status) {
        session.writeUserId(response.data!.userId);
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ViewProfileResponse> userProfileAsync() async {
    try {
      final response = await userRepository.getUserProfileAsync();
      if (response.status) {
        session.writeUserFullName(
            '${response.data!.firstName.toTitleCase()} ${response.data!.lastName.toCapitalized()}');
        session.writeRiderEmail(response.data!.email);
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserByPhoneResponse> userByPhoneAsync(
      UserByPhoneRequest request) async {
    try {
      final response = await userRepository.getUserByPhoneAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CreateWalletResponse> createWalletAsync(
      CreateWalletRequest request) async {
    try {
      final response = await userRepository.createWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ReCreateWalletResponse> reCreateWalletAsync(
      ReCreateWalletRequest request) async {
    try {
      final response = await userRepository.reCreateWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserWalletResponse> userWalletAsync() async {
    try {
      final response = await userRepository.getUserWalletAsync();
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> choosePinAsync(ChoosePinRequest request) async {
    try {
      final response = await userRepository.choosePinAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }
}
