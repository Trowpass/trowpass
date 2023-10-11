class ViewProfileResponse {
  ViewProfileData? data;
  String message;
  bool status;
  String responseCode;

  ViewProfileResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.responseCode,
  });

  factory ViewProfileResponse.fromJson(Map<String, dynamic> json) {
    return ViewProfileResponse(
      message: json['message'] ?? '',
      status: json['status'],
      responseCode: json['responseCode'] ?? '',
      data: json['data'] != null ? ViewProfileData.fromJson(json['data']) : null,
    );
  }
}

class ViewProfileData {
  int userId;
  String firstName;
  String lastName;
  String phoneNumber;
  String? email;
  dynamic bio;
  bool isAccountVerified;
  String? userAccountType;
  String? customerType;
  String? gender;
  String accountType;
  bool isActive;
  bool isVirtualCardCreated;
  bool isPinCreated;
  bool isWalletCreated;
  DateTime? dateOfBirth;
  String? placeOfBirth;
  DateTime? accountUpgradedAt;
  String? qr;
  AccountDetail? accountDetail;
  dynamic kycDetail;
  dynamic bussinessDetail;
  String profilePix;

  ViewProfileData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.bio,
    required this.isAccountVerified,
    required this.userAccountType,
    required this.customerType,
    required this.gender,
    required this.accountType,
    required this.isActive,
    required this.isVirtualCardCreated,
    required this.isPinCreated,
    required this.isWalletCreated,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.accountUpgradedAt,
    required this.qr,
    required this.accountDetail,
    required this.kycDetail,
    required this.bussinessDetail,
    required this.profilePix,
  });

  factory ViewProfileData.fromJson(Map<String, dynamic> json) {
    return ViewProfileData(
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      qr: json['qr'] ?? '',
      isAccountVerified: json['isAccountVerified'] ?? false,
      isPinCreated: json['isPinCreated'] ?? false,
      isWalletCreated: json['isWalletCreated'] ?? false,
      userAccountType: json['userAccountType'] ?? '',
      customerType: json['customerType'] ?? '',
      gender: json['gender'] ?? '',
      accountType: json['accountType'] ?? '',
      isActive: json['isActive'] ?? false,
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      placeOfBirth: json['placeOfBirth'] ?? '',
      accountUpgradedAt: json['accountUpgradedAt'] != null ? DateTime.parse(json['accountUpgradedAt']) : null,
      accountDetail: json['accountDetail'] != null ? AccountDetail.fromJson(json['accountDetail']) : null,
      kycDetail: null,
      bussinessDetail: json['bussinessDetail'] != null ? BussinessDetail.fromJson(json['bussinessDetail']) : null,
      isVirtualCardCreated: json['isVirtualCardCreated'],
      profilePix: json["profilePix"] ?? '',
    );
  }
}

class AccountDetail {
  String? accountName;
  String? accountNumber;

  AccountDetail({
    required this.accountName,
    required this.accountNumber,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) {
    return AccountDetail(
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
    );
  }
}

class BussinessDetail {
  String? businessName;
  String? slug;
  String? size;

  BussinessDetail({
    required this.businessName,
    required this.slug,
    required this.size,
  });

  factory BussinessDetail.fromJson(Map<String, dynamic> json) {
    return BussinessDetail(
      businessName: json['businessName'] ?? '',
      slug: json['slug'] ?? '',
      size: json['size'] ?? '',
    );
  }
}
