import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
var dio = Dio();

class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    RequestOptions options = err.requestOptions;
    try {
      if (err.message == null) {
        handler.reject(err);
      } else if (err.message!.contains("ERROR_001") ||
          err.response!.statusCode == 401) {
        // this will push a new route and remove all the routes that were present
        navKey.currentState!
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
        handler.reject(err);
      } else {
        var resp = await dio.request(err.requestOptions.path,
            data: options.data,
            cancelToken: options.cancelToken,
            onReceiveProgress: options.onReceiveProgress,
            onSendProgress: options.onSendProgress,
            queryParameters: options.queryParameters);
        handler.resolve(resp);
      }
    } on DioException catch (err) {
      handler.reject(err);
    }

    return err;
  }
}
