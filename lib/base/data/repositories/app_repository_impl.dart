import 'dart:io';

import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/datasources/app_datasource.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/base/domain/repositories/app_repository.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:package_info/package_info.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl extends AppRepository {
  const AppRepositoryImpl(
    this._remoteDataSource,
    this._prefsRepository,
    this._firebaseMessaging,
  ) : super(_remoteDataSource);

  final AppDataSource _remoteDataSource;
  final PrefsRepository _prefsRepository;
  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<bool> registerDevice() async {
    try {
      final firebaseToken = await _firebaseMessaging.getToken();
      final searchResult =
          await _remoteDataSource.getDevice(fbToken: firebaseToken);
      if (searchResult.isSuccess && searchResult.getOrNull() != null) {
        await _prefsRepository.setFbId(searchResult.getOrThrow().id);
        return true;
      }

      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String deviceModel;
      String deviceUuid;
      String osTypeId;
      String osVersion;
      final String appVersion = packageInfo.version;
      final int appTypeId =
          int.parse(packageInfo.buildNumber, onError: (_) => 1);

      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        osVersion = androidInfo.version.sdkInt.toString();
        deviceUuid = androidInfo.androidId;
        osTypeId = '1';
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.model;
        osVersion = iosInfo.systemVersion;
        deviceUuid = iosInfo.identifierForVendor;
        osTypeId = '2';
      }

      final result = await _remoteDataSource.registerDevice(
        firebaseToken: await _firebaseMessaging.getToken(),
        appTypeId: appTypeId,
        deviceModel: deviceModel,
        deviceUuid: deviceUuid,
        osTypeId: osTypeId,
        osVersion: osVersion,
        appVersion: appVersion,
      );
      await _prefsRepository.setFbId(result.getOrThrow().id);
      return result.isSuccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteDevice({String firebaseToken}) async {
    try {
      final result = await _remoteDataSource.deleteDevice(
        firebaseToken: firebaseToken,
      );
      return result.isSuccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getNotificationsCount() async {
    if ((_prefsRepository.token ?? '').isNotEmpty)
      try {
        final result = await _remoteDataSource.getNotificationsCount();
        return result.getOrThrow().data.first;
      } catch (e) {
        // throw ServerFailure('Failed to get notifications count!');
      }
    return Future.value(0);
  }

  @override
  Future<bool> modifyDevice(bool link) => _remoteDataSource
      .modifyDevice(link)
      .whenSuccess((res) => true)
      .catchError((_) => false);

  @override
  Future<NetworkResult<VersionResponse>> getDevice({String fbToken}) =>
      _remoteDataSource.getDevice(fbToken: fbToken);
}
