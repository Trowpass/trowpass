class KYCResponse {
  bool status;
  String message;
  String responseCode;
  KYCData data;

  KYCResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory KYCResponse.fromJson(Map<String, dynamic> json) => KYCResponse(
        status: json['status'] ?? false,
        message: json['message'] ?? '',
        responseCode: json['responseCode'] ?? '',
        data: KYCData.fromJson(json['data'] ?? {})
      );
}

class KYCData {
  String userId;
  String user; 
  String bvn;
  String address;
  String dateOfBirth;
  bool isSubmitted;
  bool isApproved;
  String dateSubmitted;
  String id;
  bool isActive;
  bool isDeleted;
  String createdBy; 
  String modifiedBy; 
  String createdAt;
  String modifiedAt;
  KYCData({
    required this.userId,
    required this.user,
    required this.bvn,
    required this.address,
    required this.dateOfBirth,
    required this.isSubmitted,
    required this.isApproved,
    required this.dateSubmitted,
    required this.id,
    required this.isActive,
    required this.isDeleted,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory KYCData.fromJson(Map<String, dynamic> json) => KYCData(
        userId: json['userId'] ?? '',
        user: json['user'] ?? '',
        bvn: json['bvn'] ?? '',
        address: json['address'] ?? '',
        dateOfBirth: json['dateOfBirth'] ?? '',
        isSubmitted: json['isSubmitted'] ?? false, 
        isApproved: json['isApproved'] ?? false, 
        dateSubmitted: json['dateSubmitted'] ?? '',
        id: json['id'] ?? '',
        isActive: json['isActive'] ?? false, 
        isDeleted: json['isDeleted'] ?? false,
        createdBy: json['createdBy'] ?? '',
        modifiedBy: json['modifiedBy'] ?? '',
        createdAt: json['createdAt'] ?? '',
        modifiedAt: json['modifiedAt'] ?? '',
      );
}
