class CreateVirtualCardResponse {
  String message;
  bool status;
  String responseCode;
  CreateVirtualCardResponseData? data;

  CreateVirtualCardResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory CreateVirtualCardResponse.fromJson(Map<String, dynamic> json) {
    return CreateVirtualCardResponse(
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
      data: json['data'] != null
          ? CreateVirtualCardResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class CreateVirtualCardResponseData {
  String? type;
  String? name;
  int balance;
  String? brand;
  String? status;
  String? pan;
  String? expiryMonth;
  int expiryYear;
  int userId;

  CreateVirtualCardResponseData({
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

  factory CreateVirtualCardResponseData.fromJson(Map<String, dynamic> json) {
    return CreateVirtualCardResponseData(
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
