class UserLoginRequest {
  String username;
  String password;
  bool shouldRememberMe;

  UserLoginRequest(
      {required this.username,
      required this.password,
      required this.shouldRememberMe});
  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'shouldRememberMe': shouldRememberMe,
      };
}
