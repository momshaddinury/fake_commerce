import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network/src/utils/failures.dart';

import '../utils/pretty_dio_logger.dart';

part 'api_options.dart';

class RestClient {
  static final RestClient _instance = RestClient._internal();

  RestClient._internal();

  factory RestClient({
    required String baseUrl,
    required String token,
    int connectionTimeout = 30000,
    int receiveTimeout = 30000,
  }) {
    _instance.baseUrl = baseUrl;
    _instance.token = token;
    _instance.connectionTimeout = connectionTimeout;
    _instance.receiveTimeout = receiveTimeout;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectionTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );

    _instance._dio = Dio(options);
    return _instance;
  }

  late Dio _dio;
  late int connectionTimeout;
  late int receiveTimeout;
  late String baseUrl;
  late String token;

  Future<Response<dynamic>> get(
    APIType apiType,
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);

    return _dio
        .get(path, queryParameters: query, options: standardHeaders)
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    standardHeaders.headers?.addAll({
      'Content-Type': 'multipart/form-data',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          options: standardHeaders,
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> patch(
    APIType api,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .patch(
          path,
          data: data,
          options: standardHeaders,
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> put(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(
          path,
          data: data,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> delete(
    APIType apiType,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .delete(
          path,
          data: data,
          queryParameters: query,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Supports media upload
  Future<Response<dynamic>> putFormData(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    final standardHeaders = await _getOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll({
        'Content-Type': 'multipart/form-data',
      });
    }
    data.addAll({
      '_method': 'PUT',
    });

    return _dio
        .post(
          path,
          data: FormData.fromMap(data),
          queryParameters: query,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Upload file in s3bucket
  Future<Response> fileUploadInS3Bucket({
    required String preAssignedUrl,
    required File file,
  }) async {
    return _dio.put(
      preAssignedUrl,
      data: file.openRead(),
      options: Options(
        headers: {
          Headers.contentLengthHeader: await file.length(),
        },
      ),
    );
  }

  dynamic _handleException(error) {
    dynamic errorData = error.response!.data;

    switch (error.response?.statusCode) {
      case 400:
        throw BadRequest(errorData);
      case 401:
        throw Unauthorized(errorData);
      case 403:
        throw Forbidden(errorData);
      case 404:
        throw NotFound(errorData);
      case 405:
        throw MethodNotAllowed(errorData);
      case 406:
        throw NotAcceptable(errorData);
      case 408:
        throw RequestTimeout(errorData);
      case 409:
        throw Conflict(errorData);
      case 410:
        throw Gone(errorData);
      case 411:
        throw LengthRequired(errorData);
      case 412:
        throw PreconditionFailed(errorData);
      case 413:
        throw PayloadTooLarge(errorData);
      case 414:
        throw URITooLong(errorData);
      case 415:
        throw UnsupportedMediaType(errorData);
      case 416:
        throw RangeNotSatisfiable(errorData);
      case 417:
        throw ExpectationFailed(errorData);
      case 422:
        throw UnprocessableEntity(errorData);
      case 429:
        throw TooManyRequests(errorData);
      case 500:
        throw InternalServerError(errorData);
      case 501:
        throw NotImplemented(errorData);
      case 502:
        throw BadGateway(errorData);
      case 503:
        throw ServiceUnavailable(errorData);
      case 504:
        throw GatewayTimeout(errorData);
      default:
        throw Unexpected(errorData);
    }
  }

  void _setDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  Future<Options> _getOptions(APIType api) async {
    switch (api) {
      case APIType.public:
        return PublicApiOptions().options;

      case APIType.protected:
        return ProtectedApiOptions(token).options;

      default:
        return PublicApiOptions().options;
    }
  }
}
