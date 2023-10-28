import 'package:app/services/responses/transaction_history/payment_method.dart';
import 'package:app/services/responses/transaction_history/payment_type.dart';
import 'package:app/services/responses/transaction_history/transaction_history_response.dart';

class DummyHistory {
  static List<TransactionHistoryData> generateDummyHistory() {
    return List.generate(
      10,
      (index) => TransactionHistoryData(
        id: 0,
        isActive: true,
        createdBy: 'Noah',
        createdAt: '2023-10-23T15:43:27.961Z',
        amount: 20000,
        reference: '9hf9whfhf89ew',
        status: 'Completed',
        currency: 'NGN',
        paymentMethod: PaymentMethod.externalTransfer,
        paymentType: PaymentType.payIn,
        source: 'Noah',
        customerId: 'id',
        accountId: 'accountId',
        fee: 50,
        drCr: 'CR',
        transactionAt: '2023-10-23T15:43:27.964Z',
      ),
    );
  }
}
