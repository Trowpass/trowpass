class CreateWalletRequest {
  int userId;

  CreateWalletRequest({
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
      };
}
