import 'package:core_sdk/utils/dio/token_option.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    @required this.baseDio,
    @required this.prefsRepository,
  });

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
  Future<RequestOptions> onRequest(RequestOptions options) async {
    if (TokenOption.needToken(options)) {
      options.headers['type'] = prefsRepository.type;

      options.headers['Authorization'] = 'Basic ' + prefsRepository.token;
    }

    // options.headers['type'] = prefsRepository.type;

    return options;
  }

  @override
  Future onError(DioError err) async {
    if ((err.response?.statusCode ?? -1) == 401) {
      // If no token, firstly lock this interceptor to prevent other request enter this interceptor.
      // then request token

      // baseDio.interceptors.requestLock.lock();
      // baseDio.interceptors.responseLock.lock();
      // tokenDio.options = baseDio.options;
      try {
        // this status mean that refresh token is invalidate and we should go
        // to login page after unlock dio for login requests
        // TODO(ahmad): you should retry to re-login with saved user info in prefs
        // TODOO(ahmad): if the above login call also return with 401 you must navigate to login page (App.navkey.currentstate.pop())
        // if ((tokenRes?.statusCode ?? -1) == 401) {
        //   throw Exception('Refresh token fail with 401');
        // } else {
        //   baseDio.interceptors.requestLock.unlock();
        //   baseDio.interceptors.responseLock.unlock();
        //   final newOptions = err.request..merge(headers: {'Authorization': 'Basic ' + prefsRepository.token});
        //   return await baseDio.request(
        //     err.request.path,
        //     data: err.request.data,
        //     queryParameters: err.request.queryParameters,
        //     cancelToken: err.request.cancelToken,
        //     options: TokenOption.needToken(err.request) ? newOptions : err.request,
        //     onSendProgress: err.request.onSendProgress,
        //     onReceiveProgress: err.request.onReceiveProgress,
        //   );
        // }
      } catch (ex) {
        print('my debug token refresh catch $ex');
        await prefsRepository.clearUserData();
        baseDio.interceptors.requestLock.unlock();
        baseDio.interceptors.responseLock.unlock();
        App.navKey.currentState
            .pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
      }
    }

    return err;
  }
}
