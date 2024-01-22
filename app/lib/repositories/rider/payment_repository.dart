import 'dart:io';

import 'package:dio/dio.dart';

import '../../services/exceptions/dio_exceptions.dart';
import '../../services/requests/rider/post_requests/credit_wallet_request.dart';
import '../../services/requests/rider/post_requests/top_up_wallet_request.dart';
import '../../services/requests/rider/post_requests/verify_paystack_transaction_request.dart';
import '../../services/responses/rider/credit_wallet_response.dart';
import '../../services/responses/rider/top_up_wallet_response.dart';
import '../../services/responses/rider/verify_paystack_transaction_response.dart';
import '../../shareds/constants/endpoints.dart';
import '../../shareds/helpers/api_connection_helper.dart';

class PaymentRepository {
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<VerifyPaystackTransactionResponse> verifyPaystackTransactionAsync(
      VerifyPaystackTransactionRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.paystackVerification);
      if (response.data != null) {
        return VerifyPaystackTransactionResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to verify payment');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TopUpWalletResponse> topUpWalletAsync(
      TopUpWalletRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.walletTopUp);
      if (response.data != null) {
        return TopUpWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to top up wallet');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CreditWalletResponse> creditWalletAsync(
      CreditWalletRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.walletTopUp);
      if (response.data != null) {
        return CreditWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to top up wallet');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
