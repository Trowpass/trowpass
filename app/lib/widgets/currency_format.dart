import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

NumberFormat currencyFormat(BuildContext context) =>
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

dynamic formatCurrency(dynamic currency) =>
    NumberFormat("##,##0.00", "en_US").format(currency);
