import 'dart:io';

import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../services/requests/post_requests/change_password_request.dart';
import '../services/requests/post_requests/reset_password_request.dart';
import '../services/requests/post_requests/rider_registration_request.dart';
import '../services/requests/post_requests/verify_otp_request.dart';
import '../services/responses/base_response.dart';
import '../services/responses/upload_profile_photo_response.dart';
import '../services/responses/user_login_response.dart';
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
          requestData: request, path: Endpoints().login);
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
          requestData: request, path: Endpoints().riderRegister);
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

  Future<BaseResponse> verifyOtpAsync(VerifyOtpRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints().verifyOtp);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
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
      var response = await apiConnectionHelper.getDataAsync(
          url: Endpoints().userProfile,
          requestOptions: Options(headers: {
            'Authorization': 'Token ${session.readAuthorizationToken()}'
          }));
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

  Future<BaseResponse> changePasswordAsync(
      ChangePasswordRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request,
          path: Endpoints().changePassword,
          requestOptions: Options(headers: {
            'Authorization': 'Token ${session.readAuthorizationToken()}'
          }));
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to change password');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resetPasswordAsync(
      ResetPasswordRequest request, String phoneNumber) async {
    try {
      final endpoint = '${Endpoints().resetPassword}?mobile=$phoneNumber';
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: endpoint);
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

  Future<BaseResponse> resetPasswordOtpAsync(
      {required String phoneNumber}) async {
    try {
      final endpoint = '${Endpoints().resetPasswordOtp}?mobile=$phoneNumber';
      var response = await apiConnectionHelper.getDataAsync(url: endpoint);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to send otp');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UploadProfilePhotoResponse> uploadProfiilePhotoAsync(
      String filePath) async {
    try {
      final uploadFormData = FormData.fromMap({
        'photo': filePath,
      });
      var response = await apiConnectionHelper.postFormData(
          requestData: uploadFormData,
          path: Endpoints().uploadProfile,
          requestOptions: Options(contentType: 'multipart/form-data', headers: {
            'Authorization': 'Token ${session.readAuthorizationToken()}'
          }));
      if (response.data != null) {
        return UploadProfilePhotoResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to upload profile image');
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
