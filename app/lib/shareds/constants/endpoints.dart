import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';
import 'otp_type.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.staging);

class Endpoints {
  String riderRegister = 'api/v1/auth/create';
  String verifyOtp = 'api/v1/auth/verify-account';
  String login = 'api/v1/auth/sign-in';
  String userProfile = 'api/v1/user/profile';
  static String forgotPassword = '/api/v1/auth/forgot-password';
  static String resetPassword = '/api/v1/auth/reset-password';
  static String resendOtpAccountVerification = 'api/v1/auth/resend-otp/${OtpType.accountVerification}';
  static String resendOtpForgetPassword = 'api/v1/auth/resend-otp/${OtpType.forgotPassword}';
}
