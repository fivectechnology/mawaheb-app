import 'package:cookie_jar/cookie_jar.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:core_sdk/utils/dio/retry_interceptor.dart';
import 'package:core_sdk/utils/dio/retry_options.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/utils/cookies_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.config.dart';

final GetIt getIt = GetIt.I;

@InjectableInit(
  initializerName: r'$inject',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> inject({String environment}) async => $inject(getIt, environment: environment);

@module
abstract class AppModule {
  @Named('ApiBaseUrl')
  String get baseUrl => '$BASE_API/v1';

  BaseOptions dioOption(@Named('ApiBaseUrl') String baseUrl) => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        contentType: 'application/json;charset=utf-8',
        responseType: ResponseType.plain,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
        },
      );

  @preResolve
  @singleton
  Future<SharedPreferences> getPrefs() => SharedPreferences.getInstance();

  @singleton
  Dio dio(BaseOptions option, Logger logger) {
    final Dio dio = Dio(option);
    return dio
      ..transformer = FlutterTransformer()
      ..interceptors.addAll(<Interceptor>[
        MawahebCookieManager(CookieJar(), logger),
        RetryInterceptor(
          dio: dio,
          logger: logger,
          options: const RetryOptions(),
        ),
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
          // logPrint: (Object err) => logger.w('LogInterceptor:$err'),
        ),
      ]);
  }

  @lazySingleton
  DataConnectionChecker getChecker() => DataConnectionChecker();

  @Singleton(as: Logger)
  LoggerImpl logger() => LoggerImpl();
}
