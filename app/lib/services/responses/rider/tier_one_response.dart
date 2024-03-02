class TierOneResponse {
  String? message;
  bool status;
  String? responseCode;
  TierOneResponseData? data;

  TierOneResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory TierOneResponse.fromJson(Map<String, dynamic> json) =>
      TierOneResponse(
          message: json['message'] ?? '',
          status: json['status'],
          responseCode: json['responseCode'] ?? '',
          data: json['data'] != null
              ? TierOneResponseData.fromJson(json['data'])
              : null);
}

class TierOneResponseData {
  String? placeOfBirth;
  DateTime dateOfBirth;
  String? gender;
  TierOneResponseAddress? address;
  String? imagePath;

  TierOneResponseData({
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.imagePath,
  });

  factory TierOneResponseData.fromJson(Map<String, dynamic> json) =>
      TierOneResponseData(
          placeOfBirth: json['placeOfBirth'] ?? '',
          dateOfBirth: DateTime.parse(json['dateOfBirth']),
          gender: json['gender'] ?? '',
          imagePath: json['imagePath'] ?? '',
          address: json['address'] != null
              ? TierOneResponseAddress.fromJson(json['address'])
              : null);
}

class TierOneResponseAddress {
  String? street;
  String? city;
  String? state;
  String? country;
  String? postalCode;

  TierOneResponseAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  factory TierOneResponseAddress.fromJson(Map<String, dynamic> json) =>
      TierOneResponseAddress(
          street: json['street'] ?? '',
          city: json['city'] ?? '',
          state: json['state'] ?? '',
          country: json['country'] ?? '',
          postalCode: json['postalCode'] ?? '');
}
