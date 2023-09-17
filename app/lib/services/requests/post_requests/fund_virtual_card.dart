class FundVirtualCardRequest {
  String fromSourceAccountNumber;
  double amount;

  FundVirtualCardRequest({
    required this.fromSourceAccountNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromSourceAccountNumber': fromSourceAccountNumber,
      'amount': amount,
    };
  }
}
