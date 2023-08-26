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

  UserLoginData({
    required this.token,
    required this.userId,
    required this.tokenExpires,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) => UserLoginData(
      token: json['token'] ?? '',
      userId: json['userId'] ?? '',
      tokenExpires: json['tokenExpires'] ?? '');
}
