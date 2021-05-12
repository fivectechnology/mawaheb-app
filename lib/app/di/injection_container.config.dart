// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core_sdk/utils/Fimber/Logger.dart' as _i5;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_messaging/firebase_messaging.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../base/data/datasources/app_datasource.dart' as _i33;
import '../../base/data/repositories/app_repository_impl.dart' as _i35;
import '../../base/data/repositories/prefs_repository_impl.dart' as _i8;
import '../../base/domain/repositories/app_repository.dart' as _i34;
import '../../base/domain/repositories/prefs_repository.dart' as _i7;
import '../../base/utils/download_helper.dart' as _i10;
import '../../features/auth/data/datasources/auth_datasource.dart' as _i36;
import '../../features/auth/data/repositories/auth_repositories_impl.dart'
    as _i38;
import '../../features/auth/domain/repositories/auth_repositories.dart' as _i37;
import '../../features/auth/viewmodels/auth_viewmodel.dart' as _i39;
import '../../features/home/data/datasources/home_datasource.dart' as _i11;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i13;
import '../../features/home/domain/repositories/home_repository.dart' as _i12;
import '../../features/home/viewmodels/home_viewmodel.dart' as _i14;
import '../../features/notifications/data/datasources/notifications_datasource.dart'
    as _i15;
import '../../features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i17;
import '../../features/notifications/domain/repositories/notifications_repository.dart'
    as _i16;
import '../../features/notifications/viewmodels/notifications_viewmodel.dart'
    as _i18;
import '../../features/players/data/datasources/players_datasource.dart'
    as _i19;
import '../../features/players/data/repositories/players_repository_impl.dart'
    as _i21;
import '../../features/players/domain/repositiories/players_repository.dart'
    as _i20;
import '../../features/players/viewmodels/players_viewmodel.dart' as _i43;
import '../../features/profile/data/datasources/profile_datasource.dart'
    as _i22;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i24;
import '../../features/profile/domain/repositories/proifile_repository.dart'
    as _i23;
import '../../features/profile/viewmodels/edit_address_viewmodel.dart' as _i40;
import '../../features/profile/viewmodels/edit_personal_viewmodel.dart' as _i41;
import '../../features/profile/viewmodels/edit_sport_viewmodel.dart' as _i42;
import '../../features/profile/viewmodels/profile_viewmodel.dart' as _i44;
import '../../features/profile/viewmodels/static_videos_viewmodel.dart' as _i4;
import '../../features/public_info/data/datasources/public_info_datasource.dart'
    as _i25;
import '../../features/public_info/data/repositories/public_info_repositiory_impl.dart'
    as _i27;
import '../../features/public_info/domain/repositories/public_info_repository.dart'
    as _i26;
import '../../features/public_info/viewmodels/public_info_viewmodels.dart'
    as _i28;
import '../../features/settings/data/datasources/settings_datasource.dart'
    as _i29;
import '../../features/settings/data/repositories/settings_repositroy_impl.dart'
    as _i46;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i45;
import '../../features/settings/viewmodels/settings_viewmodel.dart' as _i47;
import '../../features/splash/data/datasources/splash_datasource.dart' as _i30;
import '../../features/splash/data/repositories/splash_repository_impl.dart'
    as _i32;
import '../../features/splash/domain/repositories/splash_repositories.dart'
    as _i31;
import '../../features/splash/viewmodels/splash_viewmodel.dart' as _i48;
import '../viewmodels/app_viewmodel.dart' as _i49;
import 'injection_container.dart'
    as _i50; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $inject(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.FirebaseMessaging>(() => appModule.firebaseMessaging());
  gh.factory<_i4.StaticVideosViewmodel>(
      () => _i4.StaticVideosViewmodel(get<_i5.Logger>()));
  gh.factory<String>(() => appModule.baseUrl, instanceName: 'ApiBaseUrl');
  gh.factory<_i6.BaseOptions>(
      () => appModule.dioOption(get<String>(instanceName: 'ApiBaseUrl')));
  gh.lazySingleton<_i7.PrefsRepository>(
      () => _i8.PrefsRepositoryImpl(get<_i9.SharedPreferences>()));
  gh.lazySingleton<_i10.DownloadHelper>(
      () => _i10.DownloadHelper(get<_i7.PrefsRepository>(), get<_i6.Dio>()));
  gh.lazySingleton<_i11.HomeDataSource>(() => _i11.HomeDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i12.HomeRepository>(
      () => _i13.HomeRepositoryImpl(get<_i11.HomeDataSource>()));
  gh.factory<_i14.HomeViewmodel>(
      () => _i14.HomeViewmodel(get<_i5.Logger>(), get<_i12.HomeRepository>()));
  gh.lazySingleton<_i15.NotificationsDataSource>(() =>
      _i15.NotificationsDataSourceImpl(
          client: get<_i6.Dio>(),
          prefsRepository: get<_i7.PrefsRepository>(),
          logger: get<_i5.Logger>()));
  gh.lazySingleton<_i16.NotificationsRepository>(() =>
      _i17.NotificationsRepositoryImpl(get<_i15.NotificationsDataSource>()));
  gh.factory<_i18.NotificationsViewmodel>(() => _i18.NotificationsViewmodel(
      get<_i5.Logger>(), get<_i16.NotificationsRepository>()));
  gh.lazySingleton<_i19.PlayersDataSource>(() => _i19.PlayersDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i20.PlayersRepository>(() => _i21.PlayersRepositoryImpl(
      get<_i19.PlayersDataSource>(), get<_i7.PrefsRepository>()));
  gh.lazySingleton<_i22.ProfileDataSource>(() => _i22.ProfileDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i23.ProfileRepository>(() => _i24.ProfileRepositoryImpl(
      get<_i22.ProfileDataSource>(), get<_i7.PrefsRepository>()));
  gh.lazySingleton<_i25.PublicInfoDataSource>(() =>
      _i25.PublicInfoDataSourceImpl(
          client: get<_i6.Dio>(),
          prefsRepository: get<_i7.PrefsRepository>(),
          logger: get<_i5.Logger>()));
  gh.lazySingleton<_i26.PublicInfoRepository>(() =>
      _i27.PublicInfoRepositoryImpl(
          get<_i25.PublicInfoDataSource>(), get<_i7.PrefsRepository>()));
  gh.factory<_i28.PublicInfoViewmodel>(() => _i28.PublicInfoViewmodel(
      get<_i5.Logger>(),
      get<_i26.PublicInfoRepository>(),
      get<_i7.PrefsRepository>(),
      get<_i10.DownloadHelper>()));
  gh.lazySingleton<_i29.SettingsDataSource>(() => _i29.SettingsDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i30.SplashDataSource>(() => _i30.SplashDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i31.SplashRepository>(
      () => _i32.SplashRepositoryImpl(get<_i30.SplashDataSource>()));
  gh.lazySingleton<_i33.AppDataSource>(() => _i33.AppDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i34.AppRepository>(() => _i35.AppRepositoryImpl(
      get<_i33.AppDataSource>(),
      get<_i7.PrefsRepository>(),
      get<_i3.FirebaseMessaging>()));
  gh.lazySingleton<_i36.AuthDataSource>(() => _i36.AuthDataSourceImpl(
      client: get<_i6.Dio>(),
      prefsRepository: get<_i7.PrefsRepository>(),
      logger: get<_i5.Logger>()));
  gh.lazySingleton<_i37.AuthRepository>(() => _i38.AuthRepositoryImpl(
      get<_i36.AuthDataSource>(),
      get<_i7.PrefsRepository>(),
      get<_i34.AppRepository>(),
      get<_i23.ProfileRepository>()));
  gh.factory<_i39.AuthViewmodel>(() => _i39.AuthViewmodel(
      get<_i5.Logger>(),
      get<_i37.AuthRepository>(),
      get<_i7.PrefsRepository>(),
      get<_i23.ProfileRepository>()));
  gh.factory<_i40.EditAddressViewmodel>(() => _i40.EditAddressViewmodel(
      get<_i5.Logger>(),
      get<_i23.ProfileRepository>(),
      get<_i7.PrefsRepository>(),
      get<_i37.AuthRepository>()));
  gh.factory<_i41.EditPersonalViewmodel>(() => _i41.EditPersonalViewmodel(
      get<_i5.Logger>(),
      get<_i23.ProfileRepository>(),
      get<_i7.PrefsRepository>(),
      get<_i37.AuthRepository>()));
  gh.factory<_i42.EditSportViewmodel>(() => _i42.EditSportViewmodel(
      get<_i5.Logger>(),
      get<_i23.ProfileRepository>(),
      get<_i7.PrefsRepository>(),
      get<_i37.AuthRepository>()));
  gh.factory<_i43.PlayersViewmodel>(() => _i43.PlayersViewmodel(
      get<_i5.Logger>(),
      get<_i20.PlayersRepository>(),
      get<_i37.AuthRepository>(),
      get<_i23.ProfileRepository>(),
      get<_i7.PrefsRepository>()));
  gh.factory<_i44.ProfileViewmodel>(() => _i44.ProfileViewmodel(
      get<_i5.Logger>(),
      get<_i23.ProfileRepository>(),
      get<_i37.AuthRepository>(),
      get<_i7.PrefsRepository>()));
  gh.lazySingleton<_i45.SettingsRepository>(() => _i46.SettingsRepositoryImpl(
      get<_i29.SettingsDataSource>(),
      get<_i7.PrefsRepository>(),
      get<_i37.AuthRepository>()));
  gh.factory<_i47.SettingsViewmodel>(() => _i47.SettingsViewmodel(
      get<_i5.Logger>(),
      get<_i45.SettingsRepository>(),
      get<_i37.AuthRepository>(),
      get<_i7.PrefsRepository>()));
  gh.factory<_i48.SplashViewmodel>(() => _i48.SplashViewmodel(get<_i5.Logger>(),
      get<_i7.PrefsRepository>(), get<_i37.AuthRepository>()));
  gh.factory<_i49.AppViewmodel>(() => _i49.AppViewmodel(
      get<_i5.Logger>(),
      get<_i7.PrefsRepository>(),
      get<_i34.AppRepository>(),
      get<_i45.SettingsRepository>()));
  gh.singleton<_i5.Logger>(appModule.logger());
  await gh.singletonAsync<_i9.SharedPreferences>(() => appModule.getPrefs(),
      preResolve: true);
  gh.singleton<_i6.Dio>(appModule.dio(
      get<_i6.BaseOptions>(), get<_i5.Logger>(), get<_i7.PrefsRepository>()));
  return get;
}

class _$AppModule extends _i50.AppModule {}
