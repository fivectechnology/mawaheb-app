import 'dart:convert';

import 'package:core_sdk/utils/dio/token_option.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mawaheb_app/features/auth/data/models/login_response_model.dart';

import 'api_helper.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.baseDio, required this.prefsRepository});

  final PrefsRepository prefsRepository;
  final Dio baseDio;

  // We use a new Dio(to avoid dead lock) instance to request token.
  final Dio tokenDio = Dio()
    ..interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        request: true,
        // logPrint: (Object err) => logger.w('LogInterceptor:$err'),
      ),
    ]);

  @override
  Future<RequestOptions?> onRequest(options, handler) async {
    options.headers['Accept-Language'] = prefsRepository.languageCode;
    if (TokenOption.needToken(options)) {
      options.headers['Authorization'] = 'Basic ' + prefsRepository.token!;
    }
    handler.next(options);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if ((err.response?.statusCode ?? -1) == 401) {
      print('my debug token Interceptor on error invoked with $err');
      // If no token, firstly lock this interceptor to prevent other request enter this interceptor.
      // then request token

      baseDio.interceptors.requestLock.lock();
      baseDio.interceptors.responseLock.lock();
      tokenDio.options = baseDio.options;
      try {
        // this status mean that refresh token is invalidate and we should go
        // to login page after unlock dio for login requests
        final tokenRes = await tokenDio.post(
          '$BASE_PUBLIC_API/auth/login/${prefsRepository.type}',
          data: {
            'data': {'username': prefsRepository.user!.userName, 'password': prefsRepository.user!.password}
          },
        );
        // TODO(ahmad): you should retry to re-login with saved user info in prefs
        // TODOO(ahmad): if the above login call also return with 401 you must navigate to login page (App.navkey.currentstate.pop())
        if ((tokenRes.statusCode ?? -1) == 401) {
          throw Exception('Refresh token fail with 401');
        } else {
          final BaseResponseModel<LoginResponseModel> loginRes =
              BaseResponseModel.fromJson(LoginResponseModel.fromJson)(jsonDecode(tokenRes.data));
          prefsRepository.setToken(loginRes.data.data);

          baseDio.interceptors.requestLock.unlock();
          baseDio.interceptors.responseLock.unlock();
          final newOptions = err.requestOptions
            ..copyWith(headers: {'Authorization': 'Basic ' + prefsRepository.token!});
          final Options testOptions = Options(
            contentType: err.requestOptions.contentType,
            extra: err.requestOptions.extra,
            followRedirects: err.requestOptions.followRedirects,
            headers:
                !TokenOption.needToken(err.requestOptions) ? err.requestOptions.headers : err.requestOptions.headers
                  ..addAll({'Authorization': 'Basic ' + prefsRepository.token!}),
            listFormat: err.requestOptions.listFormat,
            maxRedirects: err.requestOptions.maxRedirects,
            method: err.requestOptions.method,
            receiveDataWhenStatusError: err.requestOptions.receiveDataWhenStatusError,
            receiveTimeout: err.requestOptions.receiveTimeout,
            requestEncoder: err.requestOptions.requestEncoder,
            responseDecoder: err.requestOptions.responseDecoder,
            responseType: err.requestOptions.responseType,
            sendTimeout: err.requestOptions.sendTimeout,
            validateStatus: err.requestOptions.validateStatus,
          );
          return await baseDio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            cancelToken: err.requestOptions.cancelToken,
            // TODO(abd): add handler here
            // options: TokenOption.needToken(err.requestOptions) ? newOptions : err.requestOptions,
            options: testOptions,

            onSendProgress: err.requestOptions.onSendProgress,
            onReceiveProgress: err.requestOptions.onReceiveProgress,
          );
        }
      } catch (ex) {
        print('my debug token refresh catch $ex');
        await prefsRepository.clearUserData();
        baseDio.interceptors.requestLock.unlock();
        baseDio.interceptors.responseLock.unlock();
        App.navKey.currentState!.pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
      }
    }

    return err;
  }
}
