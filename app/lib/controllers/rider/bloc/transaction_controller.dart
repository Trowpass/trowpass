import 'dart:async';

import 'package:app/repositories/rider/transaction_history_repository.dart';
import 'package:app/services/responses/rider/transaction_history/transaction_history_response.dart';

class TransactionController {
  TransactionHistoryRepository transactionRepository = TransactionHistoryRepository();

  Future<TransactionHistoryResponse> getAllTransactionHistoryAsync() async {
    try {
      final response = await transactionRepository.getAllTransactionHistoryAsync();
      return response;
    } catch (e) {
      return Future.error('Unable to fetch transactions');
    }
  }
}
