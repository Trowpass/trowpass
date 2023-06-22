class RiderRegistrationRequest {
  String firstName;
  String lastName;
  String email;
  String mobile;
  String password;
  String userType;
  String deviceToken;

  RiderRegistrationRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.password,
      required this.userType,
      required this.deviceToken});
  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile': mobile,
        'password': password,
        'user_type': userType,
        'device_token': deviceToken
      };
}
