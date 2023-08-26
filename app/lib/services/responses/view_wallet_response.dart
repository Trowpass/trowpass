class UserWalletResponse {
  bool status;
  String message;
  String responseCode;
  WalletData? data;

  UserWalletResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory UserWalletResponse.fromJson(Map<String, dynamic> json) =>
      UserWalletResponse(
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
        data: json['data'] != null ? WalletData.fromJson(json['data']) : null,
      );
}

class WalletData {
  int id;
  int accountUserId;
  String name;
  String accountNumber;
  String bankName;
  double balance;
  bool isActive;

  WalletData({
    required this.id,
    required this.accountUserId,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    required this.balance,
    required this.isActive,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json['id'] ?? 0,
        accountUserId: json['accountUserId'] ?? 0,
        name: json['name'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        bankName: json['bankName'] ?? '',
        balance: (json['balance'] ?? 0.0).toDouble(),
        isActive: json['isActive'] ?? false,
      );
}
