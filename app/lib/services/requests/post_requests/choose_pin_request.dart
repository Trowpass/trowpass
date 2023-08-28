class ChoosePinRequest {
  int userId;
  String pin;
  String confirmPin;

  ChoosePinRequest(
      {
      required this.userId,
      required this.pin,
      required this.confirmPin,
      });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'pin': pin,
        'confirmPin': confirmPin,
      };
}
