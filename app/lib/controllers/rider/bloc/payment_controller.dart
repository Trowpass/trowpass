import 'package:app/shareds/managers/rider/get_session_manager.dart';

import '../../../repositories/rider/payment_repository.dart';
import '../../../services/requests/rider/post_requests/credit_wallet_request.dart';
import '../../../services/requests/rider/post_requests/top_up_wallet_request.dart';
import '../../../services/requests/rider/post_requests/verify_paystack_transaction_request.dart';
import '../../../services/responses/rider/credit_wallet_response.dart';
import '../../../services/responses/rider/top_up_wallet_response.dart';
import '../../../services/responses/rider/verify_paystack_transaction_response.dart';

class PaymentController {
  final paymentRepository = PaymentRepository();
  GetSessionManager session = GetSessionManager();

  Future<VerifyPaystackTransactionResponse> verifyPaystackTransactionAsync(
      String reference) async {
    try {
      var userId = session.readUserId() as int;
      var request = VerifyPaystackTransactionRequest(
          userId: userId, reference: reference);
      final response =
          await paymentRepository.verifyPaystackTransactionAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error('Unable to verify payment. Please try again!');
    }
  }

  Future<TopUpWalletResponse> topUpWalletAsync(
      TopUpWalletRequest request) async {
    try {
      final response = await paymentRepository.topUpWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error('Unable to top up wallet. Please try again!');
    }
  }

  Future<CreditWalletResponse> creditWalletAsync(
      CreditWalletRequest request) async {
    try {
      final response = await paymentRepository.creditWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to credit wallet. Please try again!');
    }
  }
}
