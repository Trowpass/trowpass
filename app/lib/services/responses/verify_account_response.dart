class VerifyAccountResponse {
  String? message;
  bool status;
  String? responseCode;
  VerifyAccountData? data;

  VerifyAccountResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory VerifyAccountResponse.fromJson(Map<String, dynamic> json) =>
      VerifyAccountResponse(
        status: json['status'] ?? '',
        message: json['message'] ?? '',
        responseCode: json['responseCode'] ?? '',
        data: json['data'] != null
            ? VerifyAccountData.fromJson(json['data'])
            : null,
      );
}

class VerifyAccountData {
  int userId;

  VerifyAccountData({
    required this.userId,
  });
  factory VerifyAccountData.fromJson(Map<String, dynamic> json) =>
      VerifyAccountData(userId: json['userId']);
}
