import 'dart:io';

import 'package:app/services/requests/post_requests/choose_pin_request.dart';
import 'package:app/services/requests/post_requests/create_wallet_request.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/requests/post_requests/view_user_by_phone_request.dart';
import 'package:app/services/responses/create_wallet_response.dart';
import 'package:app/services/responses/view_user_by_phone_response.dart';
import 'package:app/services/responses/view_wallet_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../services/requests/post_requests/forget_password_request.dart';
import '../services/requests/post_requests/resend_otp_request.dart';
import '../services/requests/post_requests/reset_password_request.dart';
import '../services/requests/post_requests/rider_registration_request.dart';
import '../services/requests/post_requests/verify_otp_request.dart';
import '../services/responses/base_response.dart';
import '../services/responses/user_login_response.dart';
import '../services/responses/verify_account_response.dart';
import '../services/responses/view_profile_response.dart';
import '../shareds/constants/endpoints.dart';
import '../shareds/helpers/api_connection_helper.dart';

class UserRepository {
  GetSessionManager session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<UserLoginResponse> userLoginAsync(UserLoginRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.login);
      if (response.data != null) {
        return UserLoginResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to login');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> createRiderAccountAsync(
      RiderRegistrationRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.riderRegister);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to create rider\'s account');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<VerifyAccountResponse> verifyOtpAsync(
      VerifyOtpRequest request, dynamic customerPhoneNumber) async {
    try {
      var url = '${Endpoints.verifyOtp}/$customerPhoneNumber';
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: url);
      if (response.data != null) {
        return VerifyAccountResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to verify account');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ViewProfileResponse> getUserProfileAsync() async {
    try {
      int? userId = session.readUserId();
      var url = '${Endpoints.userProfile}/$userId';
      //
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      //
      if (response.data != null) {
        return ViewProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user profile');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserByPhoneResponse> getUserByPhoneAsync(
      UserByPhoneRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.userByPhone);
      if (response.data != null) {
        return UserByPhoneResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> requestForgotPasswordAsync(
      ForgetPasswordRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: Endpoints.forgotPassword,
      );

      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to send request');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resendOtpToPhoneNumberAsync(
      ResendOtpRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: Endpoints.resendOtpAccountVerification,
      );
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to resend otp');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resetPasswordAsync(ResetPasswordRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: '${Endpoints.resetPassword}/${request.email}',
      );

      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to reset password');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CreateWalletResponse> createWalletAsync(
      CreateWalletRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.createWallet);
      if (response.data != null) {
        return CreateWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to create tag');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resendOtpToEmailAsync(ResendOtpRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: Endpoints.resendOtpForgetPassword,
      );

      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to resend otp');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserWalletResponse> getUserWalletAsync() async {
    try {
      int? userId = session.readUserId();
      var url = '${Endpoints.userWallet}/$userId';
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      if (response.data != null) {
        return UserWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user wallet details');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> choosePinAsync(ChoosePinRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.createPin);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to create tag');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
