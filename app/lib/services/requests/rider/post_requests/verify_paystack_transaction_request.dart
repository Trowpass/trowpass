class VerifyPaystackTransactionRequest {
  int userId;
  String reference;

  VerifyPaystackTransactionRequest({
    required this.userId,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'reference': reference,
      };
}
