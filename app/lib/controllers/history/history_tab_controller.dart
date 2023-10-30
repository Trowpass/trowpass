import 'package:app/controllers/bloc/transaction_controller.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryTabController extends GetxController {
  var period = RxString('Today');
  var selectedFilterType = RxnString('New to Old');
  var filterTypes = ['New to Old', 'Old to New', 'Monthly', 'Yearly'];
  final String title = 'History';
  final scrollController = ScrollController();
  final historyItems = <TransactionHistoryData>[].obs;
  final transactionController = TransactionController();
  final isLoading = true.obs;
  final isHistorySorted = false.obs;
  var todayTransaction = <TransactionHistoryData>[].obs;
  var earlierTransaction = <TransactionHistoryData>[].obs;

  @override
  void onInit() {
    period.value = "Today";
    isLoading.value = true;
    getAllTransactionHistory();
    super.onInit();
  }

  void filterList(String sortLabel) {
    switch (sortLabel) {
      case "New to Old":
        historyItems.sort(TransactionHistoryData.sortByNewToOld);
        break;
      case "Old to New":
        historyItems.sort(TransactionHistoryData.sortByOldToNew);
        break;
      case "Monthly":
        historyItems.sort(TransactionHistoryData.sortByMonthly);
        break;
      case "Yearly":
        historyItems.sort(TransactionHistoryData.sortByYearly);
        break;
      default:
        throw UnsupportedError("$sortLabel filter is not supported yet");
    }
    selectedFilterType.value = sortLabel;
    period.value = sortLabel;
    isHistorySorted.value = true;
  }

  Future<void> getAllTransactionHistory() async {
    isLoading.value = true;
    Get.focusScope!.unfocus();
    var response = await transactionController.getAllTransactionHistoryAsync();
    if (response.status) {
      if (response.data!.isNotEmpty) {
        historyItems.value = response.data!;
        todayTransaction.value = response.data!
            .where((transaction) => transaction.isTodayTransaction)
            .toList();
        earlierTransaction.value = response.data!
            .where((transaction) => !transaction.isTodayTransaction)
            .toList();
      } else {
        historyItems.value = [];
      }
      isLoading.value = false;
    } else {
      Get.snackbar(
        'Information',
        response.message,
        colorText: Colors.white,
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
