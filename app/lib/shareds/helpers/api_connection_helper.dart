import 'dart:convert';

import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../resources/routes/api_paths.dart';

GetSessionManager session = GetSessionManager();

class ApiConnectionHelper {
  static const Duration receiveTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(seconds: 20);
  static const Duration connectTimeout = Duration(seconds: 20);

  final Dio dio = Dio(BaseOptions(
      sendTimeout: sendTimeout,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      baseUrl: baseUrl,
      contentType: 'application/json',
      validateStatus: (status) {
        if (status! >= 200) {
          return true;
        }
        return false;
      },
      headers: {'Accept': '*/*', 'x-token': session.readAuthorizationToken()}))
    ..interceptors.addAll([
      // AppInterceptors(),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90),
    ]);

  Future<Response<dynamic>> getDataAsync({
    required String url,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.get(
      url,
      options: requestOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> postDataAsync({
    dynamic requestData,
    required String path,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.post(
      path,
      data: jsonEncode(requestData),
      options: requestOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> postFormDataAsync({
    required String path,
    required FormData formData,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.post(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> updateDataAsync({
    dynamic requestData,
    required String path,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.patch(
      path,
      data: jsonEncode(requestData),
      options: requestOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> updateWithPutDataAsync({
    dynamic requestData,
    required String path,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.put(
      path,
      data: jsonEncode(requestData),
      options: requestOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> deleteDataAsync({
    dynamic requestData,
    required String path,
    Options? requestOptions,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.delete(
      path,
      data: jsonEncode(requestData),
      options: requestOptions,
      queryParameters: queryParameters,
    );
    return response;
  }
}
