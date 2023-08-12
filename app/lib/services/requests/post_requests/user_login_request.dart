class UserLoginRequest {
  String phoneNumber;
  String password;

  UserLoginRequest(
      {required this.phoneNumber,
      required this.password,
     });
  Map<String, dynamic> toJson() =>
      {'phoneNumber': phoneNumber, 'password': password,};
}
