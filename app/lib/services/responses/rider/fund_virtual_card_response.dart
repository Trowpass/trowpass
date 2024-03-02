class FundVirtualCardResponse {
  String message;
  bool status;
  String responseCode;
  FundVirtualCardResponseData? data;

  FundVirtualCardResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory FundVirtualCardResponse.fromJson(Map<String, dynamic> json) {
    return FundVirtualCardResponse(
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
      data: json['data'] != null
          ? FundVirtualCardResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class FundVirtualCardResponseData {
  String? type;
  String? name;
  int balance;
  String? brand;
  String? status;
  String? pan;
  String? expiryMonth;
  int expiryYear;
  int userId;

  FundVirtualCardResponseData({
    required this.type,
    required this.name,
    required this.balance,
    required this.brand,
    required this.status,
    required this.pan,
    required this.expiryMonth,
    required this.expiryYear,
    required this.userId,
  });

  factory FundVirtualCardResponseData.fromJson(Map<String, dynamic> json) {
    return FundVirtualCardResponseData(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      balance: json['balance'],
      brand: json['brand'] ?? '',
      status: json['status'] ?? '',
      pan: json['pan'] ?? '',
      expiryMonth: json['expiryMonth'] ?? '',
      expiryYear: json['expiryYear'],
      userId: json['userId'],
    );
  }
}
