class RiderRegistrationRequest {
  String firstName;
  String lastName;
  String email;
  String bvn;
  String phoneNumber;
  String businessName;
  String password;
  String confirmPassword;
  String userAccountType;

  RiderRegistrationRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.bvn,
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
        'bvn': bvn,
        'phoneNumber': phoneNumber,
        'businessName': businessName,
        'password': password,
        'confirmPassword': confirmPassword,
        'userAccountType': userAccountType,
      };
}
