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
import '../../features/home/data/datasources/home_datasource.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/viewmodels/home_viewmodel.dart';
import '../../features/notifications/data/datasources/notifications_datasource.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/viewmodels/notifications_viewmodel.dart';
import '../../features/players/data/datasources/players_datasource.dart';
import '../../features/players/domain/repositiories/players_repository.dart';
import '../../features/players/data/repositories/players_repository_impl.dart';
import '../../features/players/viewmodels/players_viewmodel.dart';
import '../../base/domain/repositories/prefs_repository.dart';
import '../../base/data/repositories/prefs_repository_impl.dart';
import '../../features/profile/data/datasources/profile_datasource.dart';
import '../../features/profile/domain/repositories/proifile_repository.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/viewmodels/profile_viewmodel.dart';
import '../../features/public_info/data/datasources/public_info_datasource.dart';
import '../../features/public_info/domain/repositories/public_info_repository.dart';
import '../../features/public_info/data/repositories/public_info_repositiory_impl.dart';
import '../../features/public_info/viewmodels/public_info_viewmodels.dart';
import '../../features/settings/data/datasources/settings_datasource.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/data/repositories/settings_repositroy_impl.dart';
import '../../features/settings/viewmodels/settings_viewmodel.dart';
import '../../features/splash/data/datasources/splash_datasource.dart';
import '../../features/splash/domain/repositories/splash_repositories.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
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
  gh.factory<SplashViewmodel>(
      () => SplashViewmodel(get<Logger>(), get<PrefsRepository>()));
  gh.lazySingleton<HomeDataSource>(() => HomeDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(get<HomeDataSource>()));
  gh.factory<HomeViewmodel>(
      () => HomeViewmodel(get<Logger>(), get<HomeRepository>()));
  gh.lazySingleton<NotificationsDataSource>(() => NotificationsDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(get<NotificationsDataSource>()));
  gh.factory<NotificationsViewmodel>(() =>
      NotificationsViewmodel(get<Logger>(), get<NotificationsRepository>()));
  gh.lazySingleton<PlayersDataSource>(() => PlayersDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<PlayersRepository>(
      () => PlayersRepositoryImpl(get<PlayersDataSource>()));
  gh.factory<PlayersViewmodel>(
      () => PlayersViewmodel(get<Logger>(), get<PlayersRepository>()));
  gh.lazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(get<ProfileDataSource>()));
  gh.factory<ProfileViewmodel>(
      () => ProfileViewmodel(get<Logger>(), get<ProfileRepository>()));
  gh.lazySingleton<PublicInfoDataSource>(() => PublicInfoDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<PublicInfoRepository>(() => PublicInfoRepositoryImpl(
      get<PublicInfoDataSource>(), get<PrefsRepository>()));
  gh.factory<PublicInfoViewmodel>(
      () => PublicInfoViewmodel(get<Logger>(), get<PublicInfoRepository>()));
  gh.lazySingleton<SettingsDataSource>(() => SettingsDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(get<SettingsDataSource>()));
  gh.factory<SettingsViewmodel>(
      () => SettingsViewmodel(get<Logger>(), get<SettingsRepository>()));
  gh.lazySingleton<SplashDataSource>(() => SplashDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(get<SplashDataSource>()));
  gh.lazySingleton<AuthDataSource>(() => AuthDataSourceImpl(
        client: get<Dio>(),
        prefsRepository: get<PrefsRepository>(),
        connectionChecker: get<DataConnectionChecker>(),
        logger: get<Logger>(),
      ));
  gh.lazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(get<AuthDataSource>(), get<PrefsRepository>()));
  gh.factory<AuthViewmodel>(
      () => AuthViewmodel(get<Logger>(), get<AuthRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<Logger>(appModule.logger());
  final sharedPreferences = await appModule.getPrefs();
  gh.singleton<SharedPreferences>(sharedPreferences);
  gh.singleton<PrefsRepository>(PrefsRepositoryImpl(get<SharedPreferences>()));
  gh.singleton<Dio>(appModule.dio(
    get<BaseOptions>(),
    get<Logger>(),
    get<PrefsRepository>(),
  ));
  return get;
}

class _$AppModule extends AppModule {}
