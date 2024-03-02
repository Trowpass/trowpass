class PaymentType {
  String? type;

  static PaymentType payIn = PaymentType.from(type: "payin");
  static PaymentType payOut = PaymentType.from(type: "payout");
  static PaymentType unknown = PaymentType.from(type: "unknown");

  PaymentType(this.type);

  factory PaymentType.from({type}) {
    return PaymentType(type);
  }

  @override
  String toString() {
    if (this == PaymentType.payIn) {
      return "payin";
    } else {
      return this == PaymentType.payOut ? "payout" : "unknown";
    }
  }

  @override
  bool operator ==(covariant PaymentType other) {
    if (identical(this, other)) return true;

    return other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}
