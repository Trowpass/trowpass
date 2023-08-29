class UserByPhoneResponse {
  String message;
  bool status;
  String responseCode;
  UserByPhoneData? data;

  UserByPhoneResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory UserByPhoneResponse.fromJson(Map<String, dynamic> json) {
    return UserByPhoneResponse(
      message: json['message'] ?? '',
      status: json['status'],
      responseCode: json['responseCode'] ?? '',
      data: json['data'] != null ? UserByPhoneData.fromJson(json['data']) : null,
    );
  }
}

class UserByPhoneData {
  int id;
  String userName;
  String email;
  String phoneNumber;
  String firstName;
  String lastName;
  String bio;
  String userAccountType;
  String customerType;
  String gender;
  bool isActive;
  DateTime dateOfBirth;
  String placeOfBirth;
  DateTime accountUpgradedAt;

  UserByPhoneData({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.userAccountType,
    required this.customerType,
    required this.gender,
    required this.isActive,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.accountUpgradedAt,
  });

  factory UserByPhoneData.fromJson(Map<String, dynamic> json) {
    return UserByPhoneData(
      id: json['id'] ?? 0,
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      bio: json['bio'] ?? '',
      userAccountType: json['userAccountType'] ?? '',
      customerType: json['customerType'] ?? '',
      gender: json['gender'] ?? '',
      isActive: json['isActive'] ?? false,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now(),
      placeOfBirth: json['placeOfBirth'] ?? '',
      accountUpgradedAt: json['accountUpgradedAt'] != null
          ? DateTime.parse(json['accountUpgradedAt'])
          : DateTime.now(),
    );
  }
}
