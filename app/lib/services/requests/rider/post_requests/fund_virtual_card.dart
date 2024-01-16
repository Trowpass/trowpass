class FundVirtualCardRequest {
  int amount;
  int? userId;

  FundVirtualCardRequest({required this.amount, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'amount': amount,
    };
  }
}
