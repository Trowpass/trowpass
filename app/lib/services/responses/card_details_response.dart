class CardDetailsResponse {
  String message;
  bool status;
  String responseCode;
  CardData? data;

  CardDetailsResponse({
    this.data,
    required this.message,
    required this.status,
    required this.responseCode,
  });

  factory CardDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CardDetailsResponse(
      data: json['data'] != null ? CardData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
    );
  }
}

class CardData {
  String accountId;
  String type;
  String name;
  double balance;
  String brand;
  String status;
  String encPan;
  String expiryMonth;
  int expiryYear;
  bool linked;
  int accountUserId;
  AccountUser accountUser;
  String serviceVirtualCardId;
  String id;
  bool isActive;
  String? createdBy;
  String createdAt;

  CardData({
    required this.accountId,
    required this.type,
    required this.name,
    required this.balance,
    required this.brand,
    required this.status,
    required this.encPan,
    required this.expiryMonth,
    required this.expiryYear,
    required this.linked,
    required this.accountUserId,
    required this.accountUser,
    required this.serviceVirtualCardId,
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      accountId: json['accountId'],
      type: json['type'],
      name: json['name'],
      balance: json['balance'].toDouble(),
      brand: json['brand'],
      status: json['status'],
      encPan: json['encPan'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      linked: json['linked'],
      accountUserId: json['accountUserId'],
      accountUser: AccountUser.fromJson(json['accountUser']),
      serviceVirtualCardId: json['serviceVirtualCardId'],
      id: json['id'].toString(),
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
    );
  }
}

class AccountUser {
  String firstName;
  String lastName;
  String? bio;
  bool isNew;
  String userApiKey;
  String userAccountType;
  String customerType;
  String gender;
  bool isActive;
  String dateOfBirth;
  String placeOfBirth;
  String? deletedAt;
  String? modifiedBy;
  String modifiedAt;
  String accountUpgradedAt;
  String createdAt;
  String serviceCustomerId;
  String serviceOrganizationId;
  int id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String? lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  AccountUser({
    required this.firstName,
    required this.lastName,
    this.bio,
    required this.isNew,
    required this.userApiKey,
    required this.userAccountType,
    required this.customerType,
    required this.gender,
    required this.isActive,
    required this.dateOfBirth,
    required this.placeOfBirth,
    this.deletedAt,
    this.modifiedBy,
    required this.modifiedAt,
    required this.accountUpgradedAt,
    required this.createdAt,
    required this.serviceCustomerId,
    required this.serviceOrganizationId,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.email,
    required this.normalizedEmail,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  factory AccountUser.fromJson(Map<String, dynamic> json) {
    return AccountUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'],
      isNew: json['isNew'],
      userApiKey: json['userApiKey'],
      userAccountType: json['userAccountType'],
      customerType: json['customerType'],
      gender: json['gender'],
      isActive: json['isActive'],
      dateOfBirth: json['dateOfBirth'],
      placeOfBirth: json['placeOfBirth'],
      deletedAt: json['deletedAt'],
      modifiedBy: json['modifiedBy'],
      modifiedAt: json['modifiedAt'],
      accountUpgradedAt: json['accountUpgradedAt'],
      createdAt: json['createdAt'],
      serviceCustomerId: json['serviceCustomerId'],
      serviceOrganizationId: json['serviceOrganizationId'],
      id: json['id'],
      userName: json['userName'],
      normalizedUserName: json['normalizedUserName'],
      email: json['email'],
      normalizedEmail: json['normalizedEmail'],
      emailConfirmed: json['emailConfirmed'],
      passwordHash: json['passwordHash'],
      securityStamp: json['securityStamp'],
      concurrencyStamp: json['concurrencyStamp'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'],
      twoFactorEnabled: json['twoFactorEnabled'],
      lockoutEnd: json['lockoutEnd'],
      lockoutEnabled: json['lockoutEnabled'],
      accessFailedCount: json['accessFailedCount'],
    );
  }
}
