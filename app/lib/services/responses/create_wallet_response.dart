class CreateWalletResponse {
  bool status;
  String message;
  String responseCode;
  ResponseData? data;

  CreateWalletResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) =>
      CreateWalletResponse(
        status: json['status'] ?? '',
        message: json['message'] ?? '',
        responseCode: json['responsCode'] ?? '',
        data: json['data'] != null ? ResponseData.fromJson(json['data']) : null,
      );
}

class ResponseData {
  int userId;
  int walletId;
  String name;
  int balance;

  ResponseData({
    required this.userId,
    required this.walletId,
    required this.name,
    required this.balance,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        userId: json['userId'] ?? '',
        walletId: json['walletId'] ?? '',
        name: json['name'] ?? '',
        balance: json['balance'] ?? '',
      );
}
