import 'package:dio/dio.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio _dio;
  final Logger _logger = Logger(printer: PrettyPrinter(colors: true, printEmojis: true, printTime: false));

  DioClient(this._dio) {
    _dio.interceptors.clear();
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout = Duration(milliseconds: Endpoints.receiveTimeout)
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (o, h) => h.next(o),
        onResponse: (r, h) {
          _logger.i(
              "\x1B[36m URL =>\x1B[0m ${r.requestOptions.path}\n\x1B[36m Header =>\x1B[0m ${r.requestOptions.headers}\n\x1B[36m Quarry Param =>\x1B[0m ${r.requestOptions.queryParameters}\n\x1B[36m Request =>\x1B[0m ${r.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${r.data}");
          h.next(r);
        },
        onError: (e, h) {
          _logger.e(
              "\x1B[31m URL => \x1B[33m${e.requestOptions.path}\n\x1B[31m Error Type => \x1B[33m${e.type.name}\x1B[36m - \x1B[31m Error Code =>\x1B[33m ${e.response?.statusCode}\n\x1B[31m Error Message =>\x1B[33m ${e.message}\n}");
          h.next(e);
        },
      ))
      ..options.responseType = ResponseType.json;
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
