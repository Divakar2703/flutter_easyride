// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// import 'package:luna_ai/Utils/constant.dart';
//
// class DioClient {
//   final Dio _dio;
//   final Logger _logger = Logger(printer: PrettyPrinter(colors: true, printEmojis: true, printTime: false));
//
//   DioClient(this._dio) {
//     _dio.interceptors.clear();
//     _dio
//       ..options.baseUrl = Endpoints.baseUrl
//       ..options.connectTimeout = const Duration(milliseconds: Endpoints.connectionTimeout)
//       ..options.receiveTimeout = const Duration(milliseconds: Endpoints.receiveTimeout)
//       ..interceptors.add(InterceptorsWrapper(
//         onRequest: (o, h) => h.next(o),
//         onResponse: (r, h) => h.next(r),
//         onError: (e, h) => h.next(e),
//       ))
//       ..options.responseType = ResponseType.json;
//   }
//
//   Future<Response?> get(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await _dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       print("Response${response}");
//       _logger.i(
//           "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Quarry Param =>\x1B[0m ${response.requestOptions.queryParameters}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
//       return response;
//     } catch (e) {
//       _logger.e("Error => $e");
//       rethrow;
//     }
//   }
//
//   // Post:----------------------------------------------------------------------
//   Future<Response> post(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await _dio.post(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       _logger.i(
//           "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
//       return response;
//     } catch (e) {
//       _logger.e("Error => $e");
//       rethrow;
//     }
//   }
//
//   // Put:-----------------------------------------------------------------------
//   Future<Response> put(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await _dio.put(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       _logger.i(
//           "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
//       return response;
//     } catch (e) {
//       _logger.e("Error => $e");
//       rethrow;
//     }
//   }
//
//   // Delete:--------------------------------------------------------------------
//   Future<Response> delete(
//     String url, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await _dio.delete(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       _logger.i(
//           "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
//       return response;
//     } catch (e) {
//       _logger.e("Error => $e");
//       rethrow;
//     }
//   }
// }
