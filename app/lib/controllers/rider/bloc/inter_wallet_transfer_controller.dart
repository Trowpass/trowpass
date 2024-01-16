import 'package:app/repositories/rider/inter_wallet_transfer_repository.dart';
import 'package:app/services/requests/rider/post_requests/inter_wallet_transfer_request.dart';
import 'package:app/services/responses/rider/inter_wallet_transfer_response.dart';
import 'package:app/shareds/managers/rider/set_session_manager.dart';

import '../../../shareds/managers/rider/get_session_manager.dart';

class InterwalletController {
  final InterWalletTransferRepository interWalletTransferRepository =
      InterWalletTransferRepository();
  final SetSessionManager session = SetSessionManager();
  final GetSessionManager getSession = GetSessionManager();

  Future<InterWalletTransferResponse> interWalletTransferAsync(
      InterWalletTransferRequest request) async {
    try {
      final response =
          await interWalletTransferRepository.interWalletTransferAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to transfer funds. Please try again!');
    }
  }
}
