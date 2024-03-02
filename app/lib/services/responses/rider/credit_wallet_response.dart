class CreditWalletResponse {
  dynamic data;
  String message;
  bool status;
  dynamic responseCode;

  CreditWalletResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.responseCode,
  });
  factory CreditWalletResponse.fromJson(Map<String, dynamic> json) =>
      CreditWalletResponse(
        data: json['data'],
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
      );
}
