class TopUpWalletRequest {
  String accountNumber;
  int amount;

  TopUpWalletRequest({required this.accountNumber, required this.amount});
  Map<String, dynamic> toJson() =>
      {'accountNumber': accountNumber, 'amount': amount};
}
