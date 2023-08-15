class ViewProfileResponse {
  bool status;
  String message;
  String? responseCode;
  ViewProfileData? data;

  ViewProfileResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory ViewProfileResponse.fromJson(Map<String, dynamic> json) =>
      ViewProfileResponse(
          status: json['status'],
          message: json['message'],
          responseCode: json['responseCode'] ?? '',
          data: json['data'] != null
              ? ViewProfileData.fromJson(json['data'])
              : null);
}

class ViewProfileData {
  String? userId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? businessName;
  String? email;
  String? bio;
  bool isAccountVerified;
  String? userAccountType;
  String? privateQRCode;
  AccountDetail? accountDetail;
  KycDetail? kycDetail;

  ViewProfileData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.businessName,
    required this.email,
    required this.isAccountVerified,
    required this.bio,
    required this.accountDetail,
    required this.kycDetail,
    required this.privateQRCode,
    required this.userAccountType,
  });

  factory ViewProfileData.fromJson(Map<String, dynamic> json) =>
      ViewProfileData(
          userId: json['userId'] ?? '',
          firstName: json['firstName'] ?? '',
          lastName: json['lastName'] ?? '',
          phoneNumber: json['phoneNumber'] ?? '',
          businessName: json['businessName'] ?? '',
          email: json['email'] ?? '',
          isAccountVerified: json['isAccountVerified'],
          bio: json['bio'] ?? '',
          privateQRCode: json['privateQrCode'] ?? '',
          userAccountType: json['userAccountType'] ?? '',
          accountDetail: json['accountDetail'] != null
              ? AccountDetail.fromJson(json['accountDetail'])
              : null,
          kycDetail: json['kycDetail'] != null
              ? KycDetail.fromJson(json['kycDetail'])
              : null);
}

class AccountDetail {
  String? accountName;
  String? accountNumber;

  AccountDetail({
    required this.accountName,
    required this.accountNumber,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
      accountName: json['accountName'] ?? '',
      accountNumber: json['accountNumber'] ?? '');
}

class KycDetail {
  String? bvn;
  String? address;
  String? dateOfBirth;
  bool isKycSubmitted;
  String? dateSubmitted;
  bool isKycApproved;

  KycDetail({
    required this.bvn,
    required this.address,
    required this.dateOfBirth,
    required this.isKycSubmitted,
    required this.dateSubmitted,
    required this.isKycApproved,
  });

  factory KycDetail.fromJson(Map<String, dynamic> json) => KycDetail(
      bvn: json['bvn'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      isKycSubmitted: json['isKycSubmitted'],
      dateSubmitted: json['dateSubmitted'] ?? '',
      isKycApproved: json['isKycApproved']);
}
