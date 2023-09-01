import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';
import 'otp_type.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.staging);

class Endpoints {
  String riderRegister = 'api/v1/auth/create';
  String verifyOtp = 'api/v1/auth/verify-account';
  String login = 'api/v1/auth/sign-in';
  String createPin = 'api/v1/setting/create-pin';
  String userProfile = 'api/v1/user/profile';
  String userByPhone = 'api/v1/user/details';
  static String forgotPassword = '/api/v1/auth/forgot-password';
  static String resetPassword = '/api/v1/auth/reset-password';
  static String resendOtpAccountVerification =
      'api/v1/auth/resend-otp/${OtpType.accountVerification}';
  static String resendOtpForgetPassword =
      'api/v1/auth/resend-otp/${OtpType.forgotPassword}';
  String userWallet = 'api/v1/wallet/me';
  String userKyc = 'api/v1/userkyc/create-update';
  String createWallet = 'api/v1/wallet/create';
  String interWalletTransfer = 'api/v1/wallet/inter-wallet-transfer';
}
