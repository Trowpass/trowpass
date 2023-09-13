import 'dart:io';

import 'package:app/services/requests/post_requests/create_virtual_card_request.dart';
import 'package:app/services/responses/create_virtual_card_response.dart';
import 'package:app/shareds/helpers/api_connection_helper.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../shareds/constants/endpoints.dart';

class CardsRepository {
  final apiConnectionHelper = ApiConnectionHelper();

  Future<CreateVirtualCardResponse> createVirtualCardAsync(CreateVirtualCardRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(requestData: request, path: Endpoints.createCard);
      if (response.data != null) {
        return CreateVirtualCardResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to login');
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
