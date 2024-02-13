class InterWalletTransferResponse {
  bool status;
  String message;
  String? responseCode;
  TransferResponseData? data;

  InterWalletTransferResponse({
    required this.status,
    required this.message,
    this.responseCode,
    this.data,
  });

  factory InterWalletTransferResponse.fromJson(Map<String, dynamic> json) =>
      InterWalletTransferResponse(
        status: json['status'] ?? false,
        message: json['message'] ?? '',
        responseCode: json['responseCode'],
        data: json['data'] != null
            ? TransferResponseData.fromJson(json['data'])
            : null,
      );
}

class TransferResponseData {
  String? senderName;
  String? recipientName;
  String? recipientPhoneNumber;
  String? narration;
  String? transactionType;
  String? transactionMethod;
  int? amount;

  TransferResponseData({
    this.senderName,
    this.recipientName,
    this.recipientPhoneNumber,
    this.narration,
    this.transactionType,
    this.transactionMethod,
    this.amount,
  });

  factory TransferResponseData.fromJson(Map<String, dynamic> json) =>
      TransferResponseData(
        senderName: json['senderName'],
        recipientName: json['recipientName'],
        recipientPhoneNumber: json['recipientPhoneNumber'],
        narration: json['narration'],
        transactionType: json['transactionType'],
        transactionMethod: json['transactionMethod'],
        amount: json['amount'],
      );
}
