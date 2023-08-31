class CreateWalletRequest {
  int userId;
  String walletName;

  CreateWalletRequest(
      {
      required this.userId,
      required this.walletName,
      });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'walletName': walletName,
      };
}
