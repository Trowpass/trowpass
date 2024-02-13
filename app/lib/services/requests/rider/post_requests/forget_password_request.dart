class ForgetPasswordRequest {
  final String email;

  const ForgetPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};

  @override
  String toString() {
    return 'ForgetPasswordRequest: {email: $email}';
  }
}
