import 'dart:io';

import 'package:app/services/requests/post_requests/inter_wallet_transfer_request.dart';
import 'package:app/services/responses/inter_wallet_transfer_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../shareds/constants/endpoints.dart';
import '../shareds/helpers/api_connection_helper.dart';

class InterWalletTransferRepository {
  GetSessionManager session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<InterWalletTransferResponse> interWalletTransferAsync(
      InterWalletTransferRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints().interWalletTransfer);
      if (response.data != null) {
        return InterWalletTransferResponse.fromJson(response.data);
      } else {
        throw Exception('Transaction Failed');
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
