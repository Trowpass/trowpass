class RequestResetPasswordResponse {
  String message;
  bool status;
  String? responseCode;
  RequestResetPasswordData? data;

  RequestResetPasswordResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory RequestResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      RequestResetPasswordResponse(
          message: json['message'],
          status: json['status'],
          responseCode: json['responseCode'],
          data: json['data'] != null
              ? RequestResetPasswordData.fromJson(json['data'])
              : null);
}

class RequestResetPasswordData {
  String? email;
  String? resetToken;
  bool isCodeSent;

  RequestResetPasswordData({
    required this.email,
    required this.resetToken,
    required this.isCodeSent,
  });

  factory RequestResetPasswordData.fromJson(Map<String, dynamic> json) =>
      RequestResetPasswordData(
          email: json['email'] ?? '',
          resetToken: json['resetToken'] ?? '',
          isCodeSent: json['isCodeSent']);
}
