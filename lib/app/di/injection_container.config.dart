// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.dart';
import '../viewmodels/app_viewmodel.dart';
import '../../features/auth/data/datasources/auth_datasource.dart';
import '../../features/auth/domain/repositories/auth_repositories.dart';
import '../../features/auth/data/repositories/auth_repositories_impl.dart';
import '../../features/auth/viewmodels/auth_viewmodel.dart';
import '../../features/home/viewmodels/home_viewmodel.dart';
import '../../base/domain/repositories/prefs_repository.dart';
import '../../base/data/repositories/prefs_repository_impl.dart';
import '../../features/splash/viewmodels/splash_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $inject(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<DataConnectionChecker>(() => appModule.getChecker());
  gh.factory<String>(() => appModule.baseUrl, instanceName: 'ApiBaseUrl');
  gh.factory<AppViewmodel>(() => AppViewmodel(get<Logger>()));
  gh.factory<BaseOptions>(
      () => appModule.dioOption(get<String>(instanceName: 'ApiBaseUrl')));
  gh.factory<HomeViewmodel>(() => HomeViewmodel(get<Logger>()));
  gh.factory<SplashViewmodel>(
      () => SplashViewmodel(get<Logger>(), get<PrefsRepository>()));
  gh.lazySingleton<AuthDataSource>(() => AuthDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(get<AuthDataSource>()));
  gh.factory<AuthViewmodel>(
      () => AuthViewmodel(get<Logger>(), get<AuthRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<Logger>(appModule.logger());
  final sharedPreferences = await appModule.getPrefs();
  gh.singleton<SharedPreferences>(sharedPreferences);
  gh.singleton<Dio>(appModule.dio(get<BaseOptions>(), get<Logger>()));
  gh.singleton<PrefsRepository>(PrefsRepositoryImpl(get<SharedPreferences>()));
  return get;
}

class _$AppModule extends AppModule {}
