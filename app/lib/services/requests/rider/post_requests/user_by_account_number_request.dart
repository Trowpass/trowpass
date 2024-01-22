class UserByAccountNumberRequest {
  String accountNumber;
  String bankCode;
  UserByAccountNumberRequest({
    required this.accountNumber,
    required this.bankCode,
  });

  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'bankCode': bankCode,

      };
}
