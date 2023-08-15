class VerifyPaystackTransactionRequest {
  String userId;
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
