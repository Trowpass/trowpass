import 'package:app/repositories/transaction_history_repository.dart';
import 'package:app/screens/history/mock/dummy_history.dart';
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
  final historyItems = <TransactionHistoryData?>[].obs;
  final transactionRepository = TransactionHistoryRepository();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    period.value = "Today";
    isLoading.value = true;
    getAllTransactionHistory();
  }

  void filterList(String sortLabel) {
    var listNonNull = historyItems.whereType<TransactionHistoryData>().toList();
    switch (sortLabel) {
      case "New to Old":
        listNonNull.sort(TransactionHistoryData.sortByNewToOld);
        break;
      case "Old to New":
        listNonNull.sort(TransactionHistoryData.sortByOldToNew);
        break;
      case "Monthly":
        listNonNull.sort(TransactionHistoryData.sortByMonthly);
        break;
      case "Yearly":
        listNonNull.sort(TransactionHistoryData.sortByYearly);
        break;
      default:
        throw UnsupportedError("$sortLabel filter is not supported yet");
    }
    selectedFilterType.value = sortLabel;
    period.value = sortLabel;
    historyItems.value = listNonNull;
  }

  Future<void> getAllTransactionHistory() async {
    isLoading.value = true;
    Get.focusScope!.unfocus();
    try {
      var response = await transactionRepository.getAllTransactionHistoryAsync();
      if (response.status) {
        if (response.data.isNotEmpty) {
          var todayTransaction = response.data.where((transaction) => transaction.isTodayTransaction);
          var earlierTransaction = response.data.where((transaction) => !transaction.isTodayTransaction);

          historyItems.value = [...earlierTransaction, null, ...todayTransaction];
        }
        // testing
        historyItems.value = DummyHistory.generateDummyHistory();
        isLoading.value = false;
      } else {
        Get.defaultDialog(
          title: 'Information',
          content: Text(response.message),
        );
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
