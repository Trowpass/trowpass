class BaseResponse {
  bool status;
  String message;

  BaseResponse({
    required this.status,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      BaseResponse(status: json['status'], message: json['message']);
}
