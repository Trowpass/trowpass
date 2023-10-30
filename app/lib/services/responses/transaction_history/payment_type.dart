class PaymentType {
  String? type;

  static PaymentType payIn = PaymentType.from(type: "payIn");
  static PaymentType payOut = PaymentType.from(type: "payOut");
  static PaymentType unknown = PaymentType.from(type: "unknown");

  PaymentType.from({this.type});

  @override
  String toString() {
    if (this == PaymentType.payIn) {
      return "payIn";
    } else {
      return this == PaymentType.payIn ? "payIn" : "unknown";
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