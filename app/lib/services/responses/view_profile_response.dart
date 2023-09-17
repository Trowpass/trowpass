// ignore_for_file: public_member_api_docs, sort_constructors_first
class ViewProfileResponse {
  String message;
  bool status;
  String responseCode;
  ViewProfileData? data;

  ViewProfileResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
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
  String email;
  String? bio;
  bool isAccountVerified;
  String userAccountType;
  String customerType;
  String? gender;
  String accountType;
  bool isActive;
  DateTime? dateOfBirth;
  bool isVirtualCardCreated;
  String placeOfBirth;
  DateTime? accountUpgradedAt;
  String privateQrCode;
  AccountDetail? accountDetail;
  KycDetail? kycDetail;
  BussinessDetail? bussinessDetail;

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
    required this.dateOfBirth,
    required this.isVirtualCardCreated,
    required this.placeOfBirth,
    required this.accountUpgradedAt,
    required this.privateQrCode,
    required this.accountDetail,
    required this.kycDetail,
    required this.bussinessDetail,
  });

  factory ViewProfileData.fromJson(Map<String, dynamic> json) {
    return ViewProfileData(
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      isAccountVerified: json['isAccountVerified'] ?? false,
      userAccountType: json['userAccountType'] ?? '',
      customerType: json['customerType'] ?? '',
      gender: json['gender'] ?? '',
      accountType: json['accountType'] ?? '',
      isActive: json['isActive'] ?? false,
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      placeOfBirth: json['placeOfBirth'] ?? '',
      accountUpgradedAt: json['accountUpgradedAt'] != null ? DateTime.parse(json['accountUpgradedAt']) : null,
      privateQrCode: json['privateQrCode'] ?? '',
      accountDetail: json['accountDetail'] != null ? AccountDetail.fromJson(json['accountDetail']) : null,
      kycDetail: json['kycDetail'] != null ? KycDetail.fromJson(json['kycDetail']) : null,
      bussinessDetail: json['bussinessDetail'] != null ? BussinessDetail.fromJson(json['bussinessDetail']) : null,
      isVirtualCardCreated: json[ 'isVirtualCardCreated'],
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

class KycDetail {
  String? bvn;
  Address? address;

  KycDetail({
    required this.bvn,
    required this.address,
  });

  factory KycDetail.fromJson(Map<String, dynamic> json) {
    return KycDetail(
      bvn: json['bvn'] ?? '',
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}

class Address {
  String? country;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  bool isVerified;

  Address({
    required this.country,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.isVerified,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      isVerified: json['isVerified'],
    );
  }
}
