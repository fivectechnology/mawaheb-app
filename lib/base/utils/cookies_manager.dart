import 'package:cookie_jar/cookie_jar.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class MawahebCookieManager extends CookieManager {
  MawahebCookieManager(CookieJar cookieJar, this._logger) : super(cookieJar);

  final Logger _logger;

  @override
  Future onError(DioError err) async {
    _logger.e('cookies error $err');
    if (err.response.statusCode == 401) {
      // TODO(ahmad): you should retry to re-login with saved user info in prefs
      // TODOO(ahmad): if the above login call also return with 401 you must navigate to login page (App.navkey.currentstate.pop())
    }
  }
}
