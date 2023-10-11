class FileUploadPurpose {
  static const profilePicture = FileUploadPurpose('profile_picture');
  static const kyc = FileUploadPurpose('kyc');
  static const bvn = FileUploadPurpose('bvn');
  static const qrCode = FileUploadPurpose('qr_code');
  static const walletCompanyLogo = FileUploadPurpose('wallet_company_logo');
  static const nin = FileUploadPurpose('nin');
  static const internationalPassport = FileUploadPurpose('international_passport');

  const FileUploadPurpose(this.purpose);

  final String purpose;

  @override
  String toString() => purpose;
}
