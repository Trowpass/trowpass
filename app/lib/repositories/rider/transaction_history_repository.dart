import 'dart:io';

import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../services/responses/transaction_history/transaction_history_response.dart';
import '../shareds/constants/endpoints.dart';
import '../shareds/helpers/api_connection_helper.dart';
import '../shareds/managers/get_session_manager.dart';

class TransactionHistoryRepository {
  var session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();

  Future<TransactionHistoryResponse> getAllTransactionHistoryAsync() async {
    try {
      var response = await apiConnectionHelper.getDataAsync(
        url: Endpoints.format(
          basePath: Endpoints.transactionHistoryAll,
          pathReplacement: {'userId': session.readUserId()},
        ),
      );

      if (response.data != null) {
        return TransactionHistoryResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fetch transactions');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
