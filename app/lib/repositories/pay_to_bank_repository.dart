// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:app/services/requests/post_requests/pay_to_bank_request.dart';
import 'package:app/services/requests/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/get_all_banks_reponse.dart';
import 'package:app/services/responses/get_user_by_account_response.dart';
import 'package:app/services/responses/pay_to_bank_response.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../shareds/constants/endpoints.dart';
import '../shareds/helpers/api_connection_helper.dart';

class PayToBankRepository {
  GetSessionManager session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<BanksResponse> getallBanksAsync() async {
    try {
      var url = Endpoints.banks;
      //
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      //
      if (response.data != null) {
        return BanksResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fetch banks');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<PayToBankResponse> payToBankAsync(PayToBankRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.toBank);
      if (response.data != null) {
        return PayToBankResponse.fromJson(response.data);
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

  Future<UserByAccountNumberResponse> getUserByAccountNumberAsync(
      UserByAccountNumberRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.userByAccountNumber);
      if (response.data != null) {
        return UserByAccountNumberResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user with account number');
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
