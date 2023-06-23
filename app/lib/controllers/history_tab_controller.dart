import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/history/mock/dummy_history.dart';

class HistoryTabController extends GetxController {
  var period = RxString('Today');
  var selectedFilterType = RxnString('New to Old');
  var filterTypes = [ 'New to Old', 'Old to New', 'Monthly', 'Yearly'];
  var historyItems = DummyHistory.generateDummyHistory();
  final String title = 'Histories';
  final scrollController = ScrollController();
}
