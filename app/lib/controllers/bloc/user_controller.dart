import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/services/requests/post_requests/choose_pin_request.dart';
import 'package:app/services/requests/post_requests/create_wallet_request.dart';
import 'package:app/services/requests/post_requests/forget_password_request.dart';
import 'package:app/services/requests/post_requests/re_create_wallet_request.dart';
import 'package:app/services/requests/post_requests/resend_otp_request.dart';
import 'package:app/services/requests/post_requests/rider_registration_request.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/requests/post_requests/verify_otp_request.dart';
import 'package:app/services/requests/post_requests/view_user_by_phone_request.dart';
import 'package:app/services/requests/put_requests/tier_one_request.dart';
import 'package:app/services/requests/put_requests/update_customer_data_request.dart';
import 'package:app/services/responses/base_response.dart';
import 'package:app/services/responses/create_wallet_response.dart';
import 'package:app/services/responses/file_upload_response.dart';
import 'package:app/services/responses/re_create_wallet_response.dart';
import 'package:app/services/responses/request_reset_password_response.dart';
import 'package:app/services/responses/tier_one_response.dart';
import 'package:app/services/responses/update_customer_data_response.dart';
import 'package:app/services/responses/user_login_response.dart';
import 'package:app/services/responses/view_profile_response.dart';
import 'package:app/services/responses/view_user_by_phone_response.dart';
import 'package:app/services/responses/view_wallet_response.dart';
import 'package:app/shareds/constants/file_upload_purpose.dart';
import 'package:app/shareds/managers/set_session_manager.dart';

import '../../services/requests/post_requests/reset_password_request.dart';
import '../../services/responses/reset_password_response.dart';
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
      return Future.error('Login failed. Please try again!');
    }
  }

  Future<BaseResponse> riderRegistrationAsync(
      RiderRegistrationRequest request) async {
    try {
      final response = await userRepository.createRiderAccountAsync(request);
      if (response.status) {
        session.writeRiderPhoneNumber(request.phoneNumber);
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to create account. Please try again!');
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
      return Future.error('Unable to verify otp. Please try again!');
    }
  }

  Future<ViewProfileResponse> userProfileAsync() async {
    try {
      final response = await userRepository.getUserProfileAsync();
      if (response.status) {
        session.writeUserFullName(
            '${response.data!.firstName.toTitleCase()} ${response.data!.lastName.toCapitalized()}');
        session.writeRiderEmail(response.data!.email);
        session.writePinCreated(response.data!.isPinCreated);
        session.writeAccountType(response.data!.accountType);
        session.writeVirtualCardCreated(response.data!.isVirtualCardCreated);
        session.writeQRCode(response.data!.qr!);
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch profile. Please try again!');
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
      return Future.error('Unable to get user. Please try again!');
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
      return Future.error('Unable to create wallet. Please try again!');
    }
  }

  Future<ReCreateWalletResponse> reCreateWalletAsync(
      ReCreateWalletRequest request) async {
    try {
      final response = await userRepository.reCreateWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error('Unable to create wallet. Please try again!');
    }
  }

  Future<UserWalletResponse> userWalletAsync() async {
    try {
      final response = await userRepository.getUserWalletAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch wallet. Please try again!');
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
      return Future.error('Unablet to set pin. Please try again!');
    }
  }

  Future<TierOneResponse> t1AccountUpgradeAsync(TierOneRequest request) async {
    try {
      final response = await userRepository.t1AccountUpgradeAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to upgrade account. Please try again!');
    }
  }

  Future<RequestResetPasswordResponse> requestForgotPasswordAsync(
      ForgetPasswordRequest request) async {
    try {
      final response = await userRepository.requestForgotPasswordAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unble to complete action. Please try again!');
    }
  }

  Future<BaseResponse> resendOtpToEmailAsync(ResendOtpRequest request) async {
    try {
      final response = await userRepository.resendOtpToEmailAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to resend otp. Please try again!');
    }
  }

  Future<ResetPasswordResponse> resetPasswordAsync(
      ResetPasswordRequest request) async {
    try {
      final response = await userRepository.resetPasswordAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to reset password. Please try again!');
    }
  }

  Future<FileUploadResponse> uploadFileAsync({
    required String filepath,
    required FileUploadPurpose purpose,
  }) async {
    try {
      final response = await userRepository.uploadFileAsync(
          filepath: filepath, purpose: purpose);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to upload image. Please try again!');
    }
  }

  Future<UpdateCustomerDataResponse> updateCustomerDataAsync(
      UpdateCustomerDataRequest request) async {
    try {
      final response = await userRepository.updateCustomerDataAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(
          'Unable to update customer record. Please try again!');
    }
  }
}
