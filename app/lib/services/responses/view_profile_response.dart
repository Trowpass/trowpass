class ViewProfileResponse {
  bool status;
  String message;
  ViewProfileData data;

  ViewProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ViewProfileResponse.fromJson(Map<String, dynamic> json) =>
      ViewProfileResponse(
          status: json['status'],
          message: json['message'],
          data: ViewProfileData.fromJson(json['data']));
}

class ViewProfileData {
  String userId;
  String firstName;
  String lastName;
  String phoneNumber;
  String businessName;
  String email;
  String address;
  String bio;
  String dateOfBirth;
  String accountDetail;
  bool isAccountVerified;
  String privateQRCode;
  String userAccountType;

  ViewProfileData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.businessName,
    required this.email,
    required this.address,
    required this.isAccountVerified,
    required this.bio,
    required this.dateOfBirth,
    required this.accountDetail,
    required this.privateQRCode,
    required this.userAccountType,
  });

  factory ViewProfileData.fromJson(Map<String, dynamic> json) =>
      ViewProfileData(
          userId: json['userId'] ?? '',
          firstName: json['first_name'] ?? '',
          lastName: json['last_name'] ?? '',
          phoneNumber: json['phoneNumber'] ?? '',
          businessName: json['businessName'] ?? '',
          email: json['email'] ?? '',
          address: json['address'] ?? '',
          isAccountVerified: json['isAccountVerified'] ?? '',
          bio: json['bio'] ?? '',
          dateOfBirth: json['dateOfBirth'] ?? '',
          accountDetail: json['accountDetail'] ?? '',
          privateQRCode: json['privateQRCode'] ?? '',
          userAccountType: json['userAccountType'] ?? '');
}
