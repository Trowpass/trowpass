import 'dart:io';

import 'package:app/services/requests/rider/post_requests/create_virtual_card_request.dart';
import 'package:app/services/requests/rider/post_requests/fund_virtual_card.dart';
import 'package:app/services/responses/rider/create_virtual_card_response.dart';
import 'package:app/shareds/helpers/api_connection_helper.dart';
import 'package:dio/dio.dart';

import '../../services/exceptions/dio_exceptions.dart';
import '../../services/requests/rider/put_requests/change_pin_request.dart';
import '../../services/responses/rider/card_details_response.dart';
import '../../services/responses/rider/fund_virtual_card_response.dart';
import '../../shareds/constants/endpoints.dart';

class CardsRepository {
  final apiConnectionHelper = ApiConnectionHelper();

  Future<CreateVirtualCardResponse> createVirtualCardAsync(
      CreateVirtualCardRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.createCard);
      if (response.data != null) {
        return CreateVirtualCardResponse.fromJson(response.data);
      } else {
        throw Exception('Could not create virtual card');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CardDetailsResponse> getCardDetailsAsync() async {
    try {
      var response = await apiConnectionHelper.getDataAsync(
        url: Endpoints.format(
          basePath: Endpoints.cardDetails,
          pathReplacement: {'userId': session.readUserId()},
        ),
      );
      if (response.data != null) {
        return CardDetailsResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get card details');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<FundVirtualCardResponse> fundVirtualCardAsync(
      FundVirtualCardRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.fundVirtualCard);
      if (response.data != null) {
        return FundVirtualCardResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fund card');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CreateVirtualCardResponse> changeVirtualCardPinAsync(
      ChangePinRequest request) async {
    try {
      var response = await apiConnectionHelper.updateDataAsync(
          requestData: request, path: Endpoints.changeVirtualCardPin);
      if (response.data != null) {
        return CreateVirtualCardResponse.fromJson(response.data);
      } else {
        throw Exception('Could not change virtual card\'s pin');
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
