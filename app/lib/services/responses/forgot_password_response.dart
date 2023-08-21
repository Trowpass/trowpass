class ForgotPasswordResponse {
  bool status;
  String message;
  String responseCode;

  ForgotPasswordResponse({
    required this.status,
    required this.message,
    required this.responseCode,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
      );
}
