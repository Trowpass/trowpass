class FileUploadResponse {
  final String name;
  final String path;
  final String extension;
  final String documentType;
  final String message;
  final bool status;
  final dynamic responseCode;

  FileUploadResponse({
    required this.name,
    required this.path,
    required this.extension,
    required this.documentType,
    required this.message,
    required this.status,
    required this.responseCode,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      name: json['data']['name'],
      path: json['data']['path'],
      extension: json['data']['extension'],
      documentType: json['data']['documentType'],
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'name': name,
        'path': path,
        'extension': extension,
        'documentType': documentType,
      },
      'message': message,
      'status': status,
      'responseCode': responseCode,
    };
  }
}
