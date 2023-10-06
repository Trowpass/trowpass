class CardDetailsResponse {
  final String message;
  final bool status;
  final String responseCode;
  final Data? data;

  CardDetailsResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory CardDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CardDetailsResponse(
        message: json['message'],
        status: json['status'],
        responseCode: json['responseCode'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null);
  }
}

class Data {
  final int id;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final String accountId;
  final String type;
  final String name;
  final int balance;
  final String brand;
  final String status;
  final String pan;
  final String expiryMonth;
  final int expiryYear;
  final bool linked;
  final int accountUserId;
  final String serviceVirtualCardId;
  final SecuredDataDetail? securedDataDetail;

  Data({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.accountId,
    required this.type,
    required this.name,
    required this.balance,
    required this.brand,
    required this.status,
    required this.pan,
    required this.expiryMonth,
    required this.expiryYear,
    required this.linked,
    required this.accountUserId,
    required this.serviceVirtualCardId,
    required this.securedDataDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      accountId: json['accountId'],
      type: json['type'],
      name: json['name'],
      balance: json['balance'],
      brand: json['brand'],
      status: json['status'],
      pan: json['pan'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      linked: json['linked'],
      accountUserId: json['accountUserId'],
      serviceVirtualCardId: json['serviceVirtualCardId'],
      securedDataDetail: SecuredDataDetail.fromJson(json['securedDataDetail']),
    );
  }
}

class SecuredDataDetail {
  final String pan;
  final String cvv;
  final String pin;

  SecuredDataDetail({
    required this.pan,
    required this.cvv,
    required this.pin,
  });

  factory SecuredDataDetail.fromJson(Map<String, dynamic> json) {
    return SecuredDataDetail(
      pan: json['pan'],
      cvv: json['cvv'],
      pin: json['pin'],
    );
  }
}
