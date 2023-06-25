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
  String firstName;
  String lastName;
  String mobile;
  double wallet;
  String? accountName;
  String? accountNumber;
  String bankName;
  String virtualAccountNumber;
  String virtualAccountName;
  String virtualBankName;
  bool hasPin;
  bool hasBank;
  bool haveBvn;
  String tier;
  String tier3InReview;
  String qrLink;
  String qrCode;
  dynamic profilePhoto;
  String userType;

  ViewProfileData({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.wallet,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.virtualAccountNumber,
    required this.virtualAccountName,
    required this.virtualBankName,
    required this.hasPin,
    required this.hasBank,
    required this.haveBvn,
    required this.tier,
    required this.tier3InReview,
    required this.qrLink,
    required this.qrCode,
    this.profilePhoto,
    required this.userType,
  });

  factory ViewProfileData.fromJson(Map<String, dynamic> json) =>
      ViewProfileData(
          firstName: json['first_name'],
          lastName: json['last_name'],
          mobile: json['mobile'],
          wallet: json['wallet'],
          accountName: json['account_name'] ??= '',
          accountNumber: json['account_number'] ??= '',
          bankName: json['bank_name'],
          virtualAccountNumber: json['virtual_account_number'],
          virtualAccountName: json['virtual_account_name'],
          virtualBankName: json['virtual_bank_name'],
          hasPin: json['has_pin'],
          hasBank: json['has_bank'],
          haveBvn: json['have_bvn'],
          tier: json['tier'],
          tier3InReview: json['tier3_in_review'],
          qrLink: json['qr_link'],
          qrCode: json['qr_code'],
          profilePhoto: json['profile_photo'],
          userType: json['user_type']);
}
