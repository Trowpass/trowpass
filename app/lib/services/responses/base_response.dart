class BaseResponse {
  bool status;
  String message;
  String responseCode;

  BaseResponse({
    required this.status,
    required this.message,
    required this.responseCode
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      BaseResponse(status: json['status'], message: json['message'], responseCode: json['responseCode']);
}
