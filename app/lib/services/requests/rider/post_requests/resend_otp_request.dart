class ResendOtpRequest {
  final String? phoneNumber;
  final String? email;

  const ResendOtpRequest({this.phoneNumber, this.email});

  Map<String, dynamic> toJson() => {"phoneNumber": phoneNumber, "email": email};

  @override
  String toString() {
    return 'ResendOtpRequest: {"phoneNumber": $phoneNumber, email: $email}';
  }
}
