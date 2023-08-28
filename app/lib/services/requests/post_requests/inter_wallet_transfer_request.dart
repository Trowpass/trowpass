class InterWalletTransferRequestRequest {
  int senderUserId;
  String recipientPhoneNumber;
  String narration;
  int amount;
  String pin;

  InterWalletTransferRequestRequest({
    required this.senderUserId,
    required this.recipientPhoneNumber,
    required this.narration,
    required this.amount,
    required this.pin,
  });

  Map<String, dynamic> toJson() => {
        'senderUserId': senderUserId,
        'recipientPhoneNumber': recipientPhoneNumber,
        'narration': narration,
        'amount': amount,
        'pin': pin,
      };
}
