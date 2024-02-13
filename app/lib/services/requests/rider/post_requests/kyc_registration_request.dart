class KYCRegistrationRequest {
  String bvn;
  DateTime dateOfBirth;  
  String address;

  KYCRegistrationRequest({
    required this.bvn,
    required this.dateOfBirth,
    required this.address,
  });

 factory KYCRegistrationRequest.fromJson(Map<String, dynamic> json) => KYCRegistrationRequest(
        bvn: json["bvn"] ?? '',
        address: json["address"] ?? '',
        dateOfBirth: DateTime.parse(json["dateOfBirth"] ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "bvn": bvn,
        "address": address,
        "dateOfBirth": dateOfBirth.toUtc().toIso8601String(),
    };
}
