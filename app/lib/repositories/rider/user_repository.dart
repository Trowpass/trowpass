import 'dart:io';

import 'package:app/services/requests/rider/post_requests/choose_pin_request.dart';
import 'package:app/services/requests/rider/post_requests/create_wallet_request.dart';
import 'package:app/services/requests/rider/post_requests/re_create_wallet_request.dart';
import 'package:app/services/requests/rider/post_requests/user_login_request.dart';
import 'package:app/services/requests/rider/post_requests/view_user_by_phone_request.dart';
import 'package:app/services/requests/rider/put_requests/tier_one_request.dart';
import 'package:app/services/requests/rider/put_requests/update_customer_data_request.dart';
import 'package:app/services/responses/rider/create_wallet_response.dart';
import 'package:app/services/responses/rider/file_upload_response.dart';
import 'package:app/services/responses/rider/re_create_wallet_response.dart';
import 'package:app/services/responses/rider/request_reset_password_response.dart';
import 'package:app/services/responses/rider/tier_one_response.dart';
import 'package:app/services/responses/rider/update_customer_data_response.dart';
import 'package:app/services/responses/rider/view_user_by_phone_response.dart';
import 'package:app/services/responses/rider/view_wallet_response.dart';
import 'package:app/shareds/constants/file_upload_purpose.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../../services/exceptions/dio_exceptions.dart';
import '../../services/requests/rider/post_requests/forget_password_request.dart';
import '../../services/requests/rider/post_requests/resend_otp_request.dart';
import '../../services/requests/rider/post_requests/reset_password_request.dart';
import '../../services/requests/rider/post_requests/rider_registration_request.dart';
import '../../services/requests/rider/post_requests/verify_otp_request.dart';
import '../../services/responses/rider/base_response.dart';
import '../../services/responses/rider/reset_password_response.dart';
import '../../services/responses/rider/user_login_response.dart';
import '../../services/responses/rider/verify_account_response.dart';
import '../../services/responses/rider/view_profile_response.dart';
import '../../shareds/constants/endpoints.dart';
import '../../shareds/helpers/api_connection_helper.dart';

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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<VerifyAccountResponse> verifyRiderOtpAsync(
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<VerifyAccountResponse> verifyFleetManagerOtpAsync(
      VerifyOtpRequest request, dynamic customerEmail) async {
    try {
      var url = '${Endpoints.verifyFleetManagerOtp}/$customerEmail';
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: url);
      if (response.data != null) {
        return VerifyAccountResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to verify account');
      }
    } on DioException catch (e) {
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
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      if (response.data != null) {
        return ViewProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user profile');
      }
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<RequestResetPasswordResponse> requestForgotPasswordAsync(
      ForgetPasswordRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: Endpoints.forgotPassword,
      );
      if (response.data != null) {
        return RequestResetPasswordResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to send request');
      }
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resendOtpToFleetManagerAsync(
      ResendOtpRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: Endpoints.resendOtpFleetManager,
      );
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to resend otp');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ResetPasswordResponse> resetPasswordAsync(
      ResetPasswordRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
        requestData: request,
        path: '${Endpoints.resetPassword}/${request.email}',
      );

      if (response.data != null) {
        return ResetPasswordResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to reset password');
      }
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ReCreateWalletResponse> reCreateWalletAsync(
      ReCreateWalletRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.reCreateWallet);
      if (response.data != null) {
        return ReCreateWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to create tag');
      }
    } on DioException catch (e) {
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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TierOneResponse> t1AccountUpgradeAsync(TierOneRequest request) async {
    try {
      int? userId = session.readUserId();
      var url = '${Endpoints.t1_upgrade}/$userId';
      var response = await apiConnectionHelper.updateWithPutDataAsync(
          requestData: request, path: url);
      if (response.data != null) {
        return TierOneResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to upgrade account');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<FileUploadResponse> uploadFileAsync({
    required String filepath,
    required FileUploadPurpose purpose,
  }) async {
    final data = FormData.fromMap({
      'Purpose': purpose.toString(),
      'UserId': session.readUserId(),
      'File': MultipartFile.fromFileSync(
        filepath,
        filename: filepath.split('/').last,
      ),
    });

    try {
      var response = await apiConnectionHelper.postFormDataAsync(
        path: Endpoints.fileUpload,
        formData: data,
      );
      if (response.data != null) {
        return FileUploadResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to upload document');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UpdateCustomerDataResponse> updateCustomerDataAsync(
      UpdateCustomerDataRequest request) async {
    try {
      int? userId = session.readUserId();
      var url = '${Endpoints.updateCustomerData}/$userId';
      var response = await apiConnectionHelper.updateDataAsync(
          requestData: request, path: url);

      if (response.data != null) {
        return UpdateCustomerDataResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to update customer');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
