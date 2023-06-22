class VerifyOtpRequest {
  String email;
  String code;

  VerifyOtpRequest({required this.email, required this.code});
  Map<String, dynamic> toJson() => {'email': email, 'code': code};
}
