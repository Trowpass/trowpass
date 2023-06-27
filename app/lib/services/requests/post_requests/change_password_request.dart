class ChangePasswordRequest {
  String currentPassword;
  String newPassword;

  ChangePasswordRequest(
      {required this.currentPassword, required this.newPassword});
  Map<String, dynamic> toJson() =>
      {'current_password': currentPassword, 'new_password': newPassword};
}
