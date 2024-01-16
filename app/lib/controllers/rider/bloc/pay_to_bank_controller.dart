import 'package:app/repositories/pay_to_bank_repository.dart';
import 'package:app/services/requests/post_requests/pay_to_bank_request.dart';
import 'package:app/services/requests/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/get_all_banks_reponse.dart';
import 'package:app/services/responses/get_user_by_account_response.dart';
import 'package:app/services/responses/pay_to_bank_response.dart';
import 'package:app/shareds/managers/set_session_manager.dart';

import '../../../shareds/managers/get_session_manager.dart';

class PaytToBankController {
  final PayToBankRepository payToBankRepository = PayToBankRepository();
  final SetSessionManager session = SetSessionManager();
  final GetSessionManager getSession = GetSessionManager();

  Future<BanksResponse> getallBanksAsync() async {
    try {
      final response = await payToBankRepository.getallBanksAsync();
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch bank details. Please try again!');
    }
  }

  Future<PayToBankResponse> payToBankAsync(PayToBankRequest request) async {
    try {
      final response = await payToBankRepository.payToBankAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to pay to bank. Please try again!');
    }
  }

  Future<UserByAccountNumberResponse> getUserByAccountNumberAsync(
      UserByAccountNumberRequest request) async {
    try {
      final response =
          await payToBankRepository.getUserByAccountNumberAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error('Unable to fetch account. Please try again!');
    }
  }
}
