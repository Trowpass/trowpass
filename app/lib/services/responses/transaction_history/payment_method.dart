class PaymentMethod {
  String? method;

  static PaymentMethod card = PaymentMethod.from(method: "card");
  static PaymentMethod bankTransfer = PaymentMethod.from(method: "bank_transfer");
  static PaymentMethod ussd = PaymentMethod.from(method: "ussd");
  static PaymentMethod nqr = PaymentMethod.from(method: "nqr");
  static PaymentMethod internalTransfer = PaymentMethod.from(method: "internal_transfer");
  static PaymentMethod externalTransfer = PaymentMethod.from(method: "external_transfer");

  PaymentMethod.from({this.method});

  @override
  String toString() {
    if (this == PaymentMethod.card) {
      return "Credit/Debit Card";
    } else if (this == PaymentMethod.bankTransfer) {
      return "Bank Transfer";
    } else if (this == PaymentMethod.ussd) {
      return "USSD";
    } else if (this == PaymentMethod.nqr) {
      return "NQR";
    } else if (this == PaymentMethod.internalTransfer) {
      return "Internal Transfer";
    } else if (this == PaymentMethod.externalTransfer) {
      return "External Transfer";
    } else {
      return "Unknown";
    }
  }

  @override
  bool operator ==(covariant PaymentMethod other) {
    if (identical(this, other)) return true;

    return other.method == method;
  }

  @override
  int get hashCode => method.hashCode;
}
