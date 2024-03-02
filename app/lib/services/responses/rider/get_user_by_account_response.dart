class UserByAccountNumberResponse {
  String message;
  bool status;
  String responseCode;
  UserByAccountNumberData? data;

  UserByAccountNumberResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory UserByAccountNumberResponse.fromJson(Map<String, dynamic> json) {
    return UserByAccountNumberResponse(
      message: json['message'] ?? '',
      status: json['status'],
      responseCode: json['responseCode'] ?? '',
      data:
          json['data'] != null ? UserByAccountNumberData.fromJson(json['data']) : null,
    );
  }
}

class UserByAccountNumberData {
  String accountName;
  String accountNumber;

  UserByAccountNumberData({
    required this.accountName,
    required this.accountNumber,
  });

  factory UserByAccountNumberData.fromJson(Map<String, dynamic> json) {
    return UserByAccountNumberData(
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
    );
  }
}
