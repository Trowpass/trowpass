class CreateVirtualCardResponse {
  String message;
  bool status;
  String responseCode;
  Data data;

  CreateVirtualCardResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory CreateVirtualCardResponse.fromJson(Map<String, dynamic> json) {
    return CreateVirtualCardResponse(
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int id;
  bool isActive;
  String? createdBy;
  String? createdAt;
  String? accountId;
  String type;
  String name;
  int balance;
  String brand;
  String status;
  String encPan;
  String expiryMonth;
  int expiryYear;
  bool linked;
  int accountUserId;
  AccountUser accountUser;
  String serviceVirtualCardId;

  Data({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
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
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      accountId: json['accountId'],
      type: json['type'],
      name: json['name'],
      balance: json['balance'],
      brand: json['brand'],
      status: json['status'],
      encPan: json['encPan'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      linked: json['linked'],
      accountUserId: json['accountUserId'],
      accountUser: AccountUser.fromJson(json['accountUser']),
      serviceVirtualCardId: json['serviceVirtualCardId'],
    );
  }
}

class AccountUser {
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
  String? modifiedAt;
  String accountUpgradedAt;
  String createdAt;
  String serviceCustomerId;
  String serviceOrganizationId;

  AccountUser({
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
    required this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.isNew,
    required this.userApiKey,
    required this.userAccountType,
    required this.customerType,
    required this.gender,
    required this.isActive,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.deletedAt,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.accountUpgradedAt,
    required this.createdAt,
    required this.serviceCustomerId,
    required this.serviceOrganizationId,
  });

  factory AccountUser.fromJson(Map<String, dynamic> json) {
    return AccountUser(
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
    );
  }
}
