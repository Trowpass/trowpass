class UserLoginRequest {
  String mobile;
  String password;
  String deviceToken;

  UserLoginRequest(
      {required this.mobile,
      required this.password,
      required this.deviceToken});
  Map<String, dynamic> toJson() =>
      {'mobile': mobile, 'password': password, 'device_token': deviceToken};
}
