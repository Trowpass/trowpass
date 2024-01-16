import 'package:app/repositories/topup_transport_wallet_repository.dart';
import 'package:app/services/requests/post_requests/topup_transport_wallet_request.dart';
import 'package:app/services/requests/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/get_all_banks_reponse.dart';
import 'package:app/services/responses/get_all_transport_company_response.dart';
import 'package:app/services/responses/get_user_by_account_response.dart';
import 'package:app/services/responses/topup_transport_wallet_response.dart';
import 'package:app/shareds/managers/set_session_manager.dart';

import '../../../shareds/managers/get_session_manager.dart';

class TopupTransportWalletController {
  final TopupTransportWalletRepository topupTransportWalletRepository =
      TopupTransportWalletRepository();
  final SetSessionManager session = SetSessionManager();
  final GetSessionManager getSession = GetSessionManager();

  Future<BanksResponse> getallBanksAsync() async {
    try {
      final response = await topupTransportWalletRepository.getallBanksAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch banks. Please try again!');
    }
  }

  Future<TransportCompanyResponse> getallTransportCompanyAsync() async {
    try {
      final response =
          await topupTransportWalletRepository.getallTransportCompanyAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(
          'Unable to fetch transport companies. Please try again!');
    }
  }

  Future<TopUpTransportWalletResponse> topupTransportWalletAsync(
      TopupTransportWalletRequest request) async {
    try {
      final response = await topupTransportWalletRepository
          .topupTransportWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(
          'Unable to top up transport wallet. Please try again!');
    }
  }

  Future<UserByAccountNumberResponse> getUserByAccountNumberAsync(
      UserByAccountNumberRequest request) async {
    try {
      final response = await topupTransportWalletRepository
          .getUserByAccountNumberAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch user. Please try again!');
    }
  }
}
