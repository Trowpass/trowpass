class AllExpenseTypeResponse {
  String message;
  bool status;
  String? responseCode;
  List<AllExpenseTypeResponseDatum> data;

  AllExpenseTypeResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory AllExpenseTypeResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonDataList = json['data'] ?? [];

    return AllExpenseTypeResponse(
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'] ?? '',
      data: jsonDataList
          .map((item) => AllExpenseTypeResponseDatum.fromJson(item))
          .toList(),
    );
  }
}

class AllExpenseTypeResponseDatum {
  int id;
  bool isActive;
  String? createdBy;
  DateTime createdAt;
  DateTime? deletedAt;
  String name;
  String slug;
  String? modifiedBy;
  DateTime? modifiedAt;

  AllExpenseTypeResponseDatum({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.deletedAt,
    required this.name,
    required this.slug,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory AllExpenseTypeResponseDatum.fromJson(Map<String, dynamic> json) {
    return AllExpenseTypeResponseDatum(
      id: json['id'],
      isActive: json['isActive'],
      createdBy: json['createdBy'] ?? '',
      modifiedBy: json['modifiedBy'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      modifiedAt: json['modifiedAt'] != null
          ? DateTime.parse(json['modifiedAt'])
          : null,
      name: json['name'],
      slug: json['slug'],
    );
  }
}
