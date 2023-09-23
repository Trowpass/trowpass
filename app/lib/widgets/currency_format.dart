import 'dart:io';

import 'package:intl/intl.dart';

NumberFormat get currencyFormat =>
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

String formatCurrency(num currency) =>
    NumberFormat("##,##0.00", "en_US").format(currency);
String ngnFormatCurrency(num amount) =>
    '${currencyFormat.currencySymbol}${formatCurrency(amount)}';
