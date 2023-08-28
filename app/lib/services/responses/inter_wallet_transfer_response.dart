class InterWalletTransferResponse {
  bool status;
  String message;
  String responseCode;
  TransferResponseData data;

  InterWalletTransferResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory InterWalletTransferResponse.fromJson(Map<String, dynamic> json) =>
      InterWalletTransferResponse(
        status: json['status'] ?? false,
        message: json['message'] ?? '',
        responseCode: json['responseCode'] ?? '',
        data: TransferResponseData.fromJson(json['data']),
      );
}

class TransferResponseData {
  int id;
  bool isActive;
  String createdBy;
  DateTime? createdAt;
  String walletName;
  String accountNumber;
  String bankName;
  int balance;
  String modifiedBy;
  DateTime? modifiedAt;
  int accountUserId;
  AccountUser accountUser;
  String serviceWalletId;

  TransferResponseData({
    required this.id,
    required this.isActive,
    required this.createdBy,
    this.createdAt,
    required this.walletName,
    required this.accountNumber,
    required this.bankName,
    required this.balance,
    required this.modifiedBy,
    this.modifiedAt,
    required this.accountUserId,
    required this.accountUser,
    required this.serviceWalletId,
  });

  factory TransferResponseData.fromJson(Map<String, dynamic> json) =>
      TransferResponseData(
        id: json['id'] ?? 0,
        isActive: json['isActive'] ?? false,
        createdBy: json['createdBy'] ?? '',
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        walletName: json['walletName'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        bankName: json['bankName'] ?? '',
        balance: json['balance'] ?? 0,
        modifiedBy: json['modifiedBy'] ?? '',
        modifiedAt: json['modifiedAt'] != null
            ? DateTime.parse(json['modifiedAt'])
            : null,
        accountUserId: json['accountUserId'] ?? 0,
        accountUser: AccountUser.fromJson(json['accountUser']),
        serviceWalletId: json['serviceWalletId'] ?? '',
      );
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
  DateTime? lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;
  String firstName;
  String lastName;
  String bio;
  bool isNew;
  String userApiKey;
  String userAccountType;
  String customerType;
  String gender;
  bool isActive;
  DateTime? dateOfBirth;
  String placeOfBirth;
  String deletedAt;
  String modifiedBy;
  DateTime? modifiedAt;
  DateTime? accountUpgradedAt;
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
    this.lockoutEnd,
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
    this.dateOfBirth,
    required this.placeOfBirth,
    required this.deletedAt,
    required this.modifiedBy,
    this.modifiedAt,
    this.accountUpgradedAt,
    required this.serviceCustomerId,
    required this.serviceOrganizationId,
  });

  factory AccountUser.fromJson(Map<String, dynamic> json) => AccountUser(
        id: json['id'] ?? 0,
        userName: json['userName'] ?? '',
        normalizedUserName: json['normalizedUserName'] ?? '',
        email: json['email'] ?? '',
        normalizedEmail: json['normalizedEmail'] ?? '',
        emailConfirmed: json['emailConfirmed'] ?? false,
        passwordHash: json['passwordHash'] ?? '',
        securityStamp: json['securityStamp'] ?? '',
        concurrencyStamp: json['concurrencyStamp'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        phoneNumberConfirmed: json['phoneNumberConfirmed'] ?? false,
        twoFactorEnabled: json['twoFactorEnabled'] ?? false,
        lockoutEnd: json['lockoutEnd'] != null
            ? DateTime.parse(json['lockoutEnd'])
            : null,
        lockoutEnabled: json['lockoutEnabled'] ?? false,
        accessFailedCount: json['accessFailedCount'] ?? 0,
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        bio: json['bio'] ?? '',
        isNew: json['isNew'] ?? false,
        userApiKey: json['userApiKey'] ?? '',
        userAccountType: json['userAccountType'] ?? '',
        customerType: json['customerType'] ?? '',
        gender: json['gender'] ?? '',
        isActive: json['isActive'] ?? false,
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.parse(json['dateOfBirth'])
            : null,
        placeOfBirth: json['placeOfBirth'] ?? '',
        deletedAt: json['deletedAt'] ?? '',
        modifiedBy: json['modifiedBy'] ?? '',
        modifiedAt: json['modifiedAt'] != null
            ? DateTime.parse(json['modifiedAt'])
            : null,
        accountUpgradedAt: json['accountUpgradedAt'] != null
            ? DateTime.parse(json['accountUpgradedAt'])
            : null,
        serviceCustomerId: json['serviceCustomerId'] ?? '',
        serviceOrganizationId: json['serviceOrganizationId'] ?? '',
      );
}
