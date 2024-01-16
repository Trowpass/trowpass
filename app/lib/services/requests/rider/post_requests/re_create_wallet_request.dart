class ReCreateWalletRequest {
  int userId;

  ReCreateWalletRequest({required this.userId});

  Map<String, dynamic> toJson() => {'userId': userId};
}
