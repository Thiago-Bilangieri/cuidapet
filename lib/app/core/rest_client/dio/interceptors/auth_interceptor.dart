import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:dio/dio.dart';

import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/logger/app_logger.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AppLogger _log;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AppLogger log,
  })  : _localStorage = localStorage,
        _log = log;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired = options.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY];

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN);

      //!TESTAR AQUI DEPOIS!
      if (accessToken == null) {
        handler.reject(
          DioError(
            requestOptions: options,
            error: "Expire Token",
            type: DioErrorType.cancel,
          ),
        );
      }
      options.headers[Constants.REST_CLIENT_AUTHORIZATION_KEY] = accessToken;
    } else {
      options.headers.remove(Constants.REST_CLIENT_AUTHORIZATION_KEY);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
