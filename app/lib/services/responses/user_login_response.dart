class UserLoginResponse {
  bool status;
  String message;
  String responseCode;
  UserLoginData? data;

  UserLoginResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
          status: json['status'],
          message: json['message'],
          responseCode: json['responseCode'],
          data: json['data'] != null
              ? UserLoginData.fromJson(json['data'])
              : null);
}

class UserLoginData {
  String token;
  int userId;
  String tokenExpires;
  ChecksumData? loginData;

  UserLoginData(
      {required this.token,
      required this.userId,
      required this.tokenExpires,
      this.loginData});

  factory UserLoginData.fromJson(Map<String, dynamic> json) => UserLoginData(
      token: json['token'] ?? '',
      userId: json['userId'] ?? '',
      tokenExpires: json['tokenExpires'] ?? '',
      loginData: json['loginData'] != null
          ? ChecksumData.fromJson(json['loginData'])
          : null);
}

class ChecksumData {
  bool isAccountVerified;
  bool isPinCreated;

  ChecksumData({
    required this.isAccountVerified,
    required this.isPinCreated,
  });

  factory ChecksumData.fromJson(Map<String, dynamic> json) => ChecksumData(
      isAccountVerified: json['isAccountVerified'],
      isPinCreated: json['isPinCreated']);
}
