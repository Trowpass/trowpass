class ReCreateWalletResponse {
  String? message;
  bool status;
  String? responseCode;
  ReCreateWalletData? data;

  ReCreateWalletResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory ReCreateWalletResponse.fromJson(Map<String, dynamic> json) {
    return ReCreateWalletResponse(
      message: json['message'] ?? '',
      status: json['status'],
      responseCode: json['responseCode'] ?? '',
      data: json['data'] != null ? ReCreateWalletData.fromJson(json['data']) : null,
    );
  }
}

class ReCreateWalletData {
  int userId;
  int walletId;
  String? name;
  int balance;

  ReCreateWalletData({
    required this.userId,
    required this.walletId,
    required this.name,
    required this.balance,
  });

  factory ReCreateWalletData.fromJson(Map<String, dynamic> json) {
    return ReCreateWalletData(
      userId: json['userId'],
      walletId: json['walletId'],
      name: json['name'] ?? '',
      balance: json['balance'],
    );
  }
}
