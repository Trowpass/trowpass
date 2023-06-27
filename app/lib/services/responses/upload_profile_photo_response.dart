class UploadProfilePhotoResponse {
  bool status;
  String message;
  UploadData data;

  UploadProfilePhotoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UploadProfilePhotoResponse.fromJson(Map<String, dynamic> json) =>
      UploadProfilePhotoResponse(
          status: json['status'],
          message: json['message'],
          data: UploadData.fromJson(json['data']));
}

class UploadData {
  String profilePhoto;

  UploadData({
    required this.profilePhoto,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) =>
      UploadData(profilePhoto: json['profile_photo']);
}
