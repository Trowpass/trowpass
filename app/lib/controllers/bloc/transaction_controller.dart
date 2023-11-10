import 'dart:async';

import 'package:app/repositories/transaction_history_repository.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';

class TransactionController {
  TransactionHistoryRepository transactionRepository = TransactionHistoryRepository();

  Future<TransactionHistoryResponse> getAllTransactionHistoryAsync() async {
    return await transactionRepository.getAllTransactionHistoryAsync();
  }
}
