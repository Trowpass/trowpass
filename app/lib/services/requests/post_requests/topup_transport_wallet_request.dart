class TopupTransportWalletRequest {
  String recipientAccountNumber;
  String recipientAccountName;
  int amount;
  int bankId;
  int transportCompanyId;
  int senderUserId;
  String pin;

  TopupTransportWalletRequest({
    required this.recipientAccountNumber,
    required this.recipientAccountName,
    required this.amount,
    required this.bankId,
    required this.transportCompanyId,
    required this.senderUserId,
    required this.pin
  });

  Map<String, dynamic> toJson() => {
        'recipientAccountNumber': recipientAccountNumber,
        'recipientAccountName': recipientAccountName,
        'amount': amount,
        'bankId': bankId,
        'transportCompanyId': transportCompanyId,
        'senderUserId': senderUserId,
        'pin': pin,
      };
}
