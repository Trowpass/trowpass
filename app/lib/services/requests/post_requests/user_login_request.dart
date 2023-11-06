class UserLoginRequest {
  String phoneNumber;
  String password;
  bool shouldRememberMe;

  UserLoginRequest(
      {required this.phoneNumber,
      required this.password,
      required this.shouldRememberMe});
  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'password': password,
        'shouldRememberMe': shouldRememberMe,
      };
}
