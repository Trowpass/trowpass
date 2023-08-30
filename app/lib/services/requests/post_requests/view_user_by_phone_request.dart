class UserByPhoneRequest {
  String phoneNumber;
  UserByPhoneRequest({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
      };
}
