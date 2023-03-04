import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:cuida_pet/app/core/helpers/environments.dart';
import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/logger/app_logger.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client_exception.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client_response.dart';
import 'package:dio/dio.dart';

import 'interceptors/auth_interceptor.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;
  final LocalStorage _localStorage;
  final AppLogger _appLogger;
  final _defaultOptions = BaseOptions(
    baseUrl: Environments.parans(Constants.ENV_BASE_URL_KEY),
    // baseUrl: "http://192.168.1.200:8080",
    connectTimeout: Duration(
      milliseconds: int.parse(
        Environments.parans(Constants.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY),
      ),
    ),
    receiveTimeout: Duration(
      milliseconds: int.parse(
        Environments.parans(Constants.ENV_REST_CLIENT_RECEIVE_TIMEOUT_KEY),
      ),
    ),
    // connectTimeout: 60000,
    // receiveTimeout: 60000,
  );

  DioRestClient({
    BaseOptions? baseOptions,
    required LocalStorage localStorage,
    required AppLogger appLogger,
  })  : _appLogger = appLogger,
        _localStorage = localStorage {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll(
      [
        AuthInterceptor(localStorage: _localStorage, log: _appLogger),
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ],
    );
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    // _defaultOptions.headers["Authorization"]
    return this;
  }

  @override
  RestClient unAuth() {
    _defaultOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(path,
          queryParameters: queryParameters,
          data: data,
          options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(path,
          queryParameters: queryParameters,
          options: Options(headers: headers, method: method));
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMensage: response.statusMessage);
  }

  Never _throwRestClientException(DioError dioError) {
    final response = dioError.response;
    throw RestClientException(
        error: dioError.error,
        response: RestClientResponse(
          data: response?.data,
          statusCode: response?.statusCode,
          statusMensage: response?.statusMessage,
        ),
        message: dioError.message,
        statusCode: response?.statusCode);
  }
}
