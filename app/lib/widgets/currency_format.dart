import 'dart:io';

import 'package:intl/intl.dart';

NumberFormat get currencyFormat => NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

dynamic formatCurrency(dynamic currency) => NumberFormat("##,##0.00", "en_US").format(currency);
