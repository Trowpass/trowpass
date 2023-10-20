class TierOneRequest {
  String placeOfBirth;
  DateTime dateOfBirth;
  String gender;
  T1Address address;
  String imagePath;

  TierOneRequest({
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'placeOfBirth': placeOfBirth,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'address': address.toJson(),
        'imagePath': imagePath,
      };
}

class T1Address {
  String street;
  String city;
  String state;
  String country;
  String postalCode;

  T1Address({
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
        'postalCode': postalCode,
      };
}
