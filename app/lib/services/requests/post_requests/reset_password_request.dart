class ResetPasswordRequest {
  final String otp;
  final String newPassword;
  final String email;
  final String resetToken;

  ResetPasswordRequest(
      {required this.otp,
      required this.newPassword,
      required this.email,
      required this.resetToken});

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "newPassword": newPassword,
        "confirmPassword": newPassword,
        "resetToken": resetToken
      };

  @override
  String toString() {
    return 'ForgetPasswordRequest: {"otp": $otp, newPassword: $newPassword, "email": $email, "resetToken": $resetToken}';
  }
}
