class BanksResponse {
  String message;
  bool status;
  String responseCode;
  List<ResponseData> data;

  BanksResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory BanksResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonDataList = json['data'] ?? [];
    List<ResponseData> responseDataList =
        jsonDataList.map((item) => ResponseData.fromJson(item)).toList();

    return BanksResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
      responseCode: json['responseCode'] ?? '',
      data: responseDataList,
    );
  }
}

class ResponseData {
  int id;
  bool isActive;
  String createdBy;
  DateTime createdAt;
  String bankName;
  String shortCode;
  String bankCode;

  ResponseData({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.bankName,
    required this.shortCode,
    required this.bankCode,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'isActive': isActive,
        'createdBy': createdBy,
        'createdAt': createdAt,
        'bankName': bankName,
        'shortCode': shortCode,
        'bankCode': bankCode
      };

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      id: json['id'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      bankName: json['bankName'] ?? '',
      shortCode: json['shortCode'] ?? '',
      bankCode: json['bankCode'] ?? '',
    );
  }
}
