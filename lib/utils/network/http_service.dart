import 'package:dio/dio.dart';
import 'package:notespedia/utils/network/dio_factory.dart';

class HttpService {
  //
  static var dio = DioFactory.configureDio();

  static Map<String, String> header = {
    "Content-Type": "application/json",
    "accept": "application/json",
    "api-version": "1",
    "language": "en",
  };

  static Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  static Future<Response> dioGetRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
  }) async {
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioPostRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
  }) async {
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioGetRequestWithProgress({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioPostRequestWithProgress({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioPutRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
  }) async {
    Response response;
    try {
      response = await dio.put(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioPutRequestWithProgress({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await dio.put(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

  static Future<Response> dioDeleteRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
  }) async {
    Response response;
    try {
      response = await dio.delete(
        url,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        data: data,
      );
    } on DioException catch (error) {
      throw Exception(error.message);
    }

    return response;
  }

//
}
