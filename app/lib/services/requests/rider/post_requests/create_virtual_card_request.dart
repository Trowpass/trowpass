class CreateVirtualCardRequest {
  final int? userId;
  CreateVirtualCardRequest({required this.userId});
  Map<String, dynamic> toJson() => {'userId': userId};
}
