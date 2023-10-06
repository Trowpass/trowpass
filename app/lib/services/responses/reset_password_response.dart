class ResetPasswordResponse {
  String message;
  bool status;
  String? responseCode;
  ResetPasswordData? data;

  ResetPasswordResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponse(
          message: json['message'],
          status: json['status'],
          responseCode: json['responseCode'] ?? '',
          data: json['data'] != null
              ? ResetPasswordData.fromJson(json['data'])
              : null);
}

class ResetPasswordData {
  String? otp;
  String? newPassword;
  String? confirmPassword;
  String? resetToken;

  ResetPasswordData({
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
    required this.resetToken,
  });
  factory ResetPasswordData.fromJson(Map<String, dynamic> json) =>
      ResetPasswordData(
          otp: json['otp'] ?? '',
          newPassword: json['newPassword'] ?? '',
          confirmPassword: json['confirmPassword'] ?? '',
          resetToken: json['resetToken'] ?? '');
}
