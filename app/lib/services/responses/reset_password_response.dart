class ResetPasswordResponse {
  bool status;
  String message;
  String responseCode;

  ResetPasswordResponse({
    required this.status,
    required this.message,
    required this.responseCode,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
      );
}
