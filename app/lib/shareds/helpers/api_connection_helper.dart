import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../resources/app_interceptors.dart';
import '../resources/routes/api_paths.dart';

class ApiConnectionHelper {
  final Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
      validateStatus: (status) {
        if (status! >= 200) {
          return true;
        }
        return false;
      },
      headers: {
        'Accept': '*/*',
      }))
    ..interceptors.addAll([
      AppInterceptors(),
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90),
    ]);

  Future<Response<dynamic>> getDataAsync(
      {required String url,
      Options? requestOptions,
      Map<String, dynamic>? queryParmeters}) async {
    Response response = await dio.get(url,
        options: requestOptions, queryParameters: queryParmeters);
    return response;
  }

  Future<Response<dynamic>> postDataAsync(
      {dynamic requestData,
      required String path,
      Options? requestOptions,
      Map<String, dynamic>? queryParmeters}) async {
    Response response = await dio.post(path,
        data: jsonEncode(requestData),
        options: requestOptions,
        queryParameters: queryParmeters);
    return response;
  }

  Future<Response<dynamic>> updateDataAsync(
      {dynamic requestData,
      required String path,
      Options? requestOptions,
      Map<String, dynamic>? queryParmeters}) async {
    Response response = await dio.patch(path,
        data: jsonEncode(requestData),
        options: requestOptions,
        queryParameters: queryParmeters);
    return response;
  }

  Future<Response<dynamic>> deleteDataAsync(
      {dynamic requestData,
      required String path,
      Options? requestOptions,
      Map<String, dynamic>? queryParmeters}) async {
    Response response = await dio.delete(path,
        data: jsonEncode(requestData),
        options: requestOptions,
        queryParameters: queryParmeters);
    return response;
  }
}
