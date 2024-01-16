class TransportCompanyResponse {
  String message;
  bool status;
  String responseCode;
  List<TransportCompanyResponseData> data;

  TransportCompanyResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory TransportCompanyResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonDataList = json['data'] ?? [];
    List<TransportCompanyResponseData> responseDataList =
        jsonDataList.map((item) => TransportCompanyResponseData.fromJson(item)).toList();

    return TransportCompanyResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
      responseCode: json['responseCode'] ?? '',
      data: responseDataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'responseCode': responseCode,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class TransportCompanyResponseData {
  int id;
  bool isActive;
  String createdBy;
  DateTime createdAt;
  String name; 
  String slug; 
  String logoPath; 

  TransportCompanyResponseData({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.name,
    required this.slug,
    required this.logoPath,
  });

  factory TransportCompanyResponseData.fromJson(Map<String, dynamic> json) {
    return TransportCompanyResponseData(
      id: json['id'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      name: json['name'] ?? '', 
      slug: json['slug'] ?? '',
      logoPath: json['logoPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'slug': slug,
      'logoPath': logoPath,
    };
  }
}
