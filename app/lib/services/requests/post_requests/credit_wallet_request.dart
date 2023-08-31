class CreditWalletRequest {
  String email;
  String reference;
  int amount;
  String paymentMethod;
  String currency;

  CreditWalletRequest({
    required this.email,
    required this.reference,
    required this.amount,
    required this.paymentMethod,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'amount': amount,
        'reference': reference,
        'paymentMethod': paymentMethod,
        'currency': currency
      };
}
