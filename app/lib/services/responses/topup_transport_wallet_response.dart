class TopUpTransportWalletResponse {
  String message;
  bool status;
  String? responseCode;
  TopUpTransportWalletData? data;

  TopUpTransportWalletResponse({
    required this.message,
    required this.status,
    this.responseCode,
    this.data,
  });

  factory TopUpTransportWalletResponse.fromJson(Map<String, dynamic> json) =>
      TopUpTransportWalletResponse(
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
        data: json['data'] != null
            ? TopUpTransportWalletData.fromJson(json['data'])
            : null,
      );
}

class TopUpTransportWalletData {
  String? senderName;
  String? recipientName;
  String? recipientPhoneNumber;
  String? recipientAccountNumber;
  String? narration;
  String? transactionType;
  String? transactionMethod;
  String? bank;
  int? amount;
  String? companyLogoPath;

  TopUpTransportWalletData({
    this.senderName,
    this.recipientName,
    this.recipientPhoneNumber,
    this.recipientAccountNumber,
    this.narration,
    this.transactionType,
    this.transactionMethod,
    this.bank,
    this.companyLogoPath,
    this.amount,
  });

  factory TopUpTransportWalletData.fromJson(Map<String, dynamic> json) =>
      TopUpTransportWalletData(
        senderName: json['senderName'],
        recipientName: json['recipientName'],
        recipientPhoneNumber: json['recipientPhoneNumber'],
        recipientAccountNumber: json['recipientAccountNumber'],
        narration: json['narration'],
        transactionType: json['transactionType'],
        transactionMethod: json['transactionMethod'],
        bank: json['bank'],
        companyLogoPath: json['companyLogoPath'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'recipientName': recipientName,
      'recipientPhoneNumber': recipientPhoneNumber,
      'recipientAccountNumber': recipientAccountNumber,
      'narration': narration,
      'transactionType': transactionType,
      'transactionMethod': transactionMethod,
      'bank': bank,
      'companyLogoPath': companyLogoPath,
      'amount': amount,
    };
  }
}
