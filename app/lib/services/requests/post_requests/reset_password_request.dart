class ResetPasswordRequest {
  String newPassword;
  String code;

  ResetPasswordRequest({required this.newPassword, required this.code});
  Map<String, dynamic> toJson() => {'new_password': newPassword, 'code': code};
}
