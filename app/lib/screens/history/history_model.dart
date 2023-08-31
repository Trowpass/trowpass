// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum TransactionType { debit, credit }

class HistoryModel {
  String image;
  String name;
  String time;
  String amount;
  TransactionType transactionType;

  HistoryModel({
    required this.image,
    required this.name,
    required this.time,
    required this.amount,
    required this.transactionType,
  });

  HistoryModel copyWith({
    String? image,
    String? name,
    String? time,
    String? amount,
    TransactionType? transactionType,
  }) {
    return HistoryModel(
      image: image ?? this.image,
      name: name ?? this.name,
      time: time ?? this.time,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'time': time,
      'amount': amount,
      'transactionType': TransactionType.credit,
      // 'transactionType': transactionType.toMap(),
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      image: map['image'] as String,
      name: map['name'] as String,
      time: map['time'] as String,
      amount: map['amount'] as String,
      transactionType: TransactionType.credit,
      // transactionType: TransactionType.fromMap(map['transactionType'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) => HistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoryModel(image: $image, name: $name, time: $time, amount: $amount, transactionType: $transactionType)';
  }

  @override
  bool operator ==(covariant HistoryModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.name == name &&
        other.time == time &&
        other.amount == amount &&
        other.transactionType == transactionType;
  }

  @override
  int get hashCode {
    return image.hashCode ^ name.hashCode ^ time.hashCode ^ amount.hashCode ^ transactionType.hashCode;
  }
}
