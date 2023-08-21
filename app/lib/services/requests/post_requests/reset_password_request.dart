class ResetPasswordRequest {
  final String otp;
  final String newPassword;
  final String email;

  ResetPasswordRequest({required this.otp, required this.newPassword, required this.email});

  Map<String, dynamic> toJson() => {"otp": otp, "newPassword": newPassword, "confirmPassword": newPassword};

  @override
  String toString() {
    return 'ForgetPasswordRequest: {"otp": $otp, newPassword: $newPassword}';
  }
}
