import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.staging);

class Endpoints {
  String riderRegister = 'api/v1/auth/create';
  String verifyOtp = 'api/v1/auth/verify-account';
  String resendOtp = 'api/v1/auth/resend-otp';
  String login = 'api/v1/auth/sign-in';
  String userProfile = 'api/v1/user/profile';
  String userWallet = 'api/v1/wallet/me';
  String userKyc = 'api/v1/userkyc/create-update';
  String createWallet = 'api/v1/wallet/create';
}
