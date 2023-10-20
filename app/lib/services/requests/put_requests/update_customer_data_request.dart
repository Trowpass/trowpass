class UpdateCustomerDataRequest {
  String firstName;
  String lastName;
  String phoneNumber;
  String bio;
  String bvn;
  UpdateCustomerDataAddress address;

  UpdateCustomerDataRequest({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.bio,
    required this.bvn,
    required this.address,
  });
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': address.toJson(),
        'bio': bio,
        'bvn': bvn
      };
}

class UpdateCustomerDataAddress {
  String street;
  String city;
  String state;
  String country;
  String postalCode;

  UpdateCustomerDataAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });
  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode
      };
}
