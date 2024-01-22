class VerifyPaystackTransactionResponse {
  String? message;
  bool status;
  String? responseCode;
  VerifyData? data;

  VerifyPaystackTransactionResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory VerifyPaystackTransactionResponse.fromJson(
          Map<String, dynamic> json) =>
      VerifyPaystackTransactionResponse(
          status: json['status'],
          responseCode: json['responseCode'] ?? '',
          message: json['message'] ?? '',
          data:
              json['data'] != null ? VerifyData.fromJson(json['data']) : null);
}

class VerifyData {
  String? status;
  String? message;
  int amount;
  String? channel;
  int userId;
  String? transactionReference;

  VerifyData({
    required this.status,
    required this.message,
    required this.amount,
    required this.channel,
    required this.userId,
    required this.transactionReference,
  });

  factory VerifyData.fromJson(Map<String, dynamic> json) => VerifyData(
      userId: json['userId'],
      status: json['status'] ?? '',
      channel: json['channel'] ?? '',
      message: json['message'] ?? '',
      transactionReference: json['phoneNumber'] ?? '',
      amount: json['amount']);
}
