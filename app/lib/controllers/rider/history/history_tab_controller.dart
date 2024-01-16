import 'package:app/controllers/rider/bloc/transaction_controller.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:get/get.dart';

class HistoryTabController extends GetxController {
  var period = RxString('Today');
  var selectedFilterType = RxnString('New to Old');
  var filterTypes = ['New to Old', 'Old to New', 'Monthly', 'Yearly'];
  final String title = 'History';
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
    try {
      var response = await transactionController.getAllTransactionHistoryAsync();
      if ((response.data ?? []).isNotEmpty) {
        historyItems.value = response.data!;
        todayTransaction.value = response.data!.where((transaction) => transaction.isTodayTransaction).toList();
        earlierTransaction.value = response.data!.where((transaction) => !transaction.isTodayTransaction).toList();
      }
      isLoading.value = false;
    } on Exception catch (err) {
      Get.snackbar(
        'Information',
        err.toString(),
        backgroundColor: dialogInfoBackground,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }
}
