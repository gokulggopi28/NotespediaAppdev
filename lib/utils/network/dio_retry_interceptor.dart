import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notespedia/utils/network/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    } else {
      super.onError(err, handler);
      return err;
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout &&
        err.type == DioExceptionType.sendTimeout &&
        err.type == DioExceptionType.receiveTimeout &&
        err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }
}
