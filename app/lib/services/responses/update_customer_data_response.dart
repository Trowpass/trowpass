class UpdateCustomerDataResponse {
  dynamic data;
  String message;
  bool status;
  String responseCode;

  UpdateCustomerDataResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.responseCode,
  });
  factory UpdateCustomerDataResponse.fromJson(Map<String, dynamic> json) =>
      UpdateCustomerDataResponse(
          status: json['status'],
          message: json['message'],
          responseCode: json['responseCode'],
          data: json['data']);
}
