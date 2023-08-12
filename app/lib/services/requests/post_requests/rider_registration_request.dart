class RiderRegistrationRequest {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String businessName;
  String password;
  String confirmPassword;
  String userAccountType;

  RiderRegistrationRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.businessName,
      required this.password,
      required this.confirmPassword,
      required this.userAccountType,
      });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'businessName': businessName,
        'password': password,
        'confirmPassword': confirmPassword,
        'userAccountType': userAccountType,
      };
}
