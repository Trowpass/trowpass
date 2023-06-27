import 'package:app/repositories/user_repository.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/requests/post_requests/verify_otp_request.dart';

import '../../services/requests/post_requests/change_password_request.dart';
import '../../services/requests/post_requests/reset_password_request.dart';
import '../../services/requests/post_requests/rider_registration_request.dart';
import '../../services/responses/base_response.dart';
import '../../services/responses/upload_profile_photo_response.dart';
import '../../services/responses/user_login_response.dart';
import '../../services/responses/view_profile_response.dart';

class UserController {
  final userRepository = UserRepository();

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
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> verifyOtpAsync(VerifyOtpRequest request) async {
    try {
      final response = await userRepository.verifyOtpAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ViewProfileResponse> userProfileAsync() async {
    try {
      final response = await userRepository.getUserProfileAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> changePasswordAsync(
      ChangePasswordRequest request) async {
    try {
      final response = await userRepository.changePasswordAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resetPasswordAsync(
      ResetPasswordRequest request, phoneNumber) async {
    try {
      final response =
          await userRepository.resetPasswordAsync(request, phoneNumber);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> resetPasswordOtpAsync(phoneNumber) async {
    try {
      final response =
          await userRepository.resetPasswordOtpAsync(phoneNumber: phoneNumber);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UploadProfilePhotoResponse> uploadProfiilePhotoAsync(fileUrl) async {
    try {
      final response = await userRepository.uploadProfiilePhotoAsync(fileUrl);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }
}
