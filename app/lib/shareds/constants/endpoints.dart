import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';
import 'otp_type.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.staging);

class Endpoints {
  static const String riderRegister = 'api/v1/auth/create';
  static const String verifyOtp = 'api/v1/auth/verify-account';
  static const String login = 'api/v1/auth/sign-in';
  static const String createPin = 'api/v1/setting/create-pin';
  static const String userProfile = 'api/v1/user/profile';
  static const String userByPhone = 'api/v1/user/details';
  static const String forgotPassword = '/api/v1/auth/forgot-password';
  static const String resetPassword = '/api/v1/auth/reset-password';
  static const String resendOtpAccountVerification = 'api/v1/auth/resend-otp/${OtpType.accountVerification}';
  static const String resendOtpForgetPassword = 'api/v1/auth/resend-otp/${OtpType.forgotPassword}';
  static const String userWallet = 'api/v1/wallet/me';
  static const String userKyc = 'api/v1/userkyc/create-update';
  static const String createWallet = 'api/v1/wallet/create';
  static const String interWalletTransfer = 'api/v1/wallet/inter-wallet-transfer';
  static const String paystackVerification = 'api/v1/paystack/verify-transaction';
  static const String walletTopUp = 'api/v1/paystack/credit-wallet';
  static const String createCard = '/api/v1/card/create-virtual-card';
  static const String fundVirtualCard = '/api/v1/card/fund-virtual-card/{userId}';
  static const String cardDetails = '/api/v1/card/{userId}';

  final String? path;
  const Endpoints(this.path);

  factory Endpoints.format({
    required String basePath,
    required Map<String, dynamic> pathReplacement,
  }) {
    return Endpoints(_EndpointFormatter(basePath).formatEndpoint(pathReplacement));
  }

  /// returns the path
  @override
  String toString() => path ?? '';
}

class _EndpointFormatter {
  final String basePath;

  _EndpointFormatter(this.basePath);

  String formatEndpoint(Map<String, dynamic> pathReplacement) {
    String formattedEndpoint = basePath;

    pathReplacement.forEach((path, value) {
      final placeholder = '{$path}';
      formattedEndpoint = formattedEndpoint.replaceFirst(placeholder, value.toString());
    });

    return formattedEndpoint;
  }
}
