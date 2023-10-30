import 'package:app/widgets/currency_format.dart';
import 'package:intl/intl.dart';

import 'payment_method.dart';
import 'payment_type.dart';

class TransactionHistoryResponse {
  String message;
  bool status;
  String responseCode;
  List<TransactionHistoryData>? data;

  TransactionHistoryResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      message: json['message'],
      status: json['status'],
      responseCode: json['responseCode'],
      // data: (json['data'] as List<dynamic>)
      //     .map((transactionData) =>
      //         TransactionHistoryData.fromJson(transactionData))
      //     .toList(),
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((transactionData) =>
                  TransactionHistoryData.fromJson(transactionData))
              .toList()
          : null,
    );
  }
}

class TransactionHistoryData {
  int id;
  bool isActive;
  String createdBy;
  String createdAt;
  double amount;
  String reference;
  String status;
  String currency;
  PaymentMethod paymentMethod;
  PaymentType paymentType;
  String source;
  String customerName;
  String accountId;
  double fee;
  String drCr;
  String transactionAt;

  TransactionHistoryData({
    required this.id,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.amount,
    required this.reference,
    required this.status,
    required this.currency,
    required this.paymentMethod,
    required this.paymentType,
    required this.source,
    required this.customerName,
    required this.accountId,
    required this.fee,
    required this.drCr,
    required this.transactionAt,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryData(
      id: json['id'],
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      amount: json['amount'],
      reference: json['reference'],
      status: json['status'],
      currency: json['currency'],
      paymentMethod: PaymentMethod.from(method: json['paymentMethod']),
      paymentType: PaymentType.from(type: json['paymentType']),
      source: json['source'],
      customerName: json['customerName'],
      accountId: json['accountId'],
      fee: json['fee'],
      drCr: json['drCr'],
      transactionAt: json['transactionAt'],
    );
  }

  DateTime get transactedAtDate => DateTime.parse(transactionAt);
  bool get isTodayTransaction => transactedAtDate.day == DateTime.now().day;
  String get formattedDate => DateFormat('d, MMMM y').format(transactedAtDate);
  String get formattedDateTime =>
      DateFormat('y-MM-dd, HH:mm:ss').format(transactedAtDate);
  String get displayFee => ngnFormatCurrency(fee);

  String get displayAmountWithPS {
    if (paymentType == PaymentType.payOut) {
      return "-${ngnFormatCurrency(amount)}";
    } else if (paymentType == PaymentType.payIn) {
      return "+${ngnFormatCurrency(amount)}";
    } else {
      return '+${ngnFormatCurrency(0)}';
    }
  }

  String get displayAmount {
    if (paymentType == PaymentType.payOut) {
      return ngnFormatCurrency(amount);
    } else if (paymentType == PaymentType.payIn) {
      return ngnFormatCurrency(amount);
    } else {
      return ngnFormatCurrency(0);
    }
  }

  static int Function(TransactionHistoryData, TransactionHistoryData)
      sortByNewToOld =
      (a, b) => a.transactedAtDate.compareTo(b.transactedAtDate);

  static int Function(TransactionHistoryData, TransactionHistoryData)
      sortByOldToNew =
      (a, b) => -(a.transactedAtDate.compareTo(b.transactedAtDate));

  static int Function(TransactionHistoryData, TransactionHistoryData)
      sortByMonthly =
      (a, b) => a.transactedAtDate.month.compareTo(b.transactedAtDate.month);

  static int Function(TransactionHistoryData, TransactionHistoryData)
      sortByYearly =
      (a, b) => a.transactedAtDate.year.compareTo(b.transactedAtDate.year);
}
