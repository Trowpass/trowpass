class UserLoginResponse {
  bool status;
  String message;
  UserLoginData data;

  UserLoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserLoginResponse(
          status: json['status'],
          message: json['message'],
          data: UserLoginData.fromJson(json['data']));
}

class UserLoginData {
  String token;
  String uid;
  String userId;
  String mobile;
  String email;
  String firstName;
  String lastName;
  String username;
  bool userIsActivated;
  bool userHasPin;
  bool suspend;
  String tokenType;
  String userType;

  UserLoginData({
    required this.token,
    required this.uid,
    required this.userId,
    required this.mobile,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.userIsActivated,
    required this.userHasPin,
    required this.suspend,
    required this.tokenType,
    required this.userType,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) => UserLoginData(
      token: json['token'],
      uid: json['uid'],
      userId: json['user_id'],
      mobile: json['mobile'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      userIsActivated: json['user_is_activated'],
      userHasPin: json['user_has_pin'],
      suspend: json['suspend'],
      tokenType: json['tokenType'],
      userType: json['user_type']);
}
