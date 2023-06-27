import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.staging);

class Endpoints {
  String riderRegister = 'user/register/';
  String verifyOtp = 'user/verify/';
  String resendOtp = 'user/resend-otp';
  String login = 'user/login/';
  String userProfile = 'user/view-profile/';
  String changePassword = 'user/update-password/';
  String uploadProfile = 'user/upload-photo/';
  String resetPassword = 'user/reset-password/';
  String resetPasswordOtp = 'user/reset-password-otp';
}
