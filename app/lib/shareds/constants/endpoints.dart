import '../enums/environment.dart';
import '../helpers/api_config_helper.dart';
import 'otp_type.dart';

String baseUrl = getBaseUrlOnEnvironment(Environment.prod);

class Endpoints {
  static const String resendOtp = 'user/resend-otp';
  static const String transactionHistoryAll = '/api/v1/transaction/histories/{userId}';
  static const String transactionHistorySingle = '/api/v1/transaction/{id}/histories/details/{userId}';
  static const String riderRegister = 'api/v1/auth/create';
  static const String verifyOtp = 'api/v1/auth/verify-account';
  static const String login = 'api/v1/auth/sign-in';
  static const String createPin = 'api/v1/setting/create-pin';
  static const String userProfile = 'api/v1/user/profile';
  static const String userByPhone = 'api/v1/user/details';
  static const String userByAccountNumber =
      'api/v1/transfer/verify-bank-account';
  static const String forgotPassword = '/api/v1/auth/forgot-password';
  static const String resetPassword = '/api/v1/auth/reset-password';
  static const String resendOtpAccountVerification =
      'api/v1/auth/resend-otp/${OtpType.accountVerification}';
  static const String resendOtpForgetPassword =
      'api/v1/auth/resend-otp/${OtpType.forgotPassword}';
  static const String userWallet = 'api/v1/wallet/me';
  static const String userKyc = 'api/v1/userkyc/create-update';
  static const String createWallet = 'api/v1/wallet/create';
  static const String reCreateWallet = 'api/v1/wallet/re-create-wallet';
  static const String interWalletTransfer =
      'api/v1/wallet/inter-wallet-transfer';
  static const String paystackVerification =
      'api/v1/paystack/verify-transaction';
  static const String walletTopUp = 'api/v1/paystack/credit-wallet';
  static const String banks = 'api/v1/transfer/banks';
  static const String toBank = 'api/v1/transfer/bank-transfer';
  static const String transportWallet =
      'api/v1/transfer/top-up-transport-wallet';
  static const String transportCompany =
      'api/v1/transfer/transport-company/all';
  static const String createCard = '/api/v1/card/create-virtual-card';
  static const String fundVirtualCard = '/api/v1/card/fund-virtual-card';
  static const String cardDetails = '/api/v1/card/{userId}';
  static const String changeVirtualCardPin =
      '/api/v1/card/change-virtual-card-pin';
  static const String updateCustomerData = '/api/v1/user';
  static const String t1_upgrade = '/api/v1/accountupgrade/t1';
  static const String fileUpload = '/api/v1/setting/file-uploader';

  static String format({
    required String basePath,
    required Map<String, dynamic> pathReplacement,
  }) {
    return _EndpointFormatter(basePath).formatEndpoint(pathReplacement);
  }
}

class _EndpointFormatter {
  final String basePath;

  _EndpointFormatter(this.basePath);

  String formatEndpoint(Map<String, dynamic> pathReplacement) {
    String formattedEndpoint = basePath;

    pathReplacement.forEach((path, value) {
      final placeholder = '{$path}';
      formattedEndpoint =
          formattedEndpoint.replaceFirst(placeholder, value.toString());
    });

    return formattedEndpoint;
  }
}
