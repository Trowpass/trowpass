class ChangePinRequest {
  int userId;
  String oldPin;
  String newPin;

  ChangePinRequest({
    required this.userId,
    required this.oldPin,
    required this.newPin,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'oldPin': oldPin,
      'newPin': newPin,
    };
  }
}
