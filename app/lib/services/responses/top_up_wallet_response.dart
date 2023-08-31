class TopUpWalletResponse {
  String? message;
  bool status;
  String? responseCode;
  TopUpWalletData? data;

  TopUpWalletResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory TopUpWalletResponse.fromJson(Map<String, dynamic> json) =>
      TopUpWalletResponse(
          status: json['status'],
          message: json['message'],
          responseCode: json['responseCode'],
          data: json['data'] != null
              ? TopUpWalletData.fromJson(json['data'])
              : null);
}

class TopUpWalletData {
  String? reference;
  int amount;
  int balance;
  String createdAt;

  TopUpWalletData({
    required this.reference,
    required this.amount,
    required this.balance,
    required this.createdAt,
  });

  factory TopUpWalletData.fromJson(Map<String, dynamic> json) =>
      TopUpWalletData(
          reference: json['reference'] ?? '',
          amount: json['amount'],
          balance: json['balance'],
          createdAt: json['createdAt']);
}
