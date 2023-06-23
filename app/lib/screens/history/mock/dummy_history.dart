import 'package:app/shareds/utils/images.dart';

import '../history_model.dart';

class DummyHistory {
  static List<HistoryModel?> generateDummyHistory() {
    String time = '20, May 2021';

    // null is added to separate the "Today" section from the "Earlier" section
    return [
      HistoryModel(
        amount: '+N2000',
        image: profile,
        name: 'Daisy Black',
        time: time,
        transactionType: TransactionType.credit,
      ),
      HistoryModel(
        amount: '-N1500',
        image: profile,
        name: 'Medley White',
        time: time,
        transactionType: TransactionType.debit,
      ),
      null,
      HistoryModel(
        amount: '+N2000',
        image: profile,
        name: 'Sade Gold',
        time: time,
        transactionType: TransactionType.credit,
      ),
      HistoryModel(
        amount: '-N1700',
        image: profile,
        name: 'Noah Wesley',
        time: time,
        transactionType: TransactionType.debit,
      ),
      HistoryModel(
        amount: '+N4000',
        image: profile,
        name: 'Victor Brown',
        time: time,
        transactionType: TransactionType.credit,
      ),
    ];
  }
}
