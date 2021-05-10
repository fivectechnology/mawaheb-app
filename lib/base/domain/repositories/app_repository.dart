import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/base/data/datasources/app_datasource.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

abstract class AppRepository extends BaseRepository {
  const AppRepository(AppDataSource appDataSource) : super(appDataSource);

  Future<bool> registerDevice();

  Future<bool> deleteDevice({required String firebaseToken});

  Future<int> getNotificationsCount();

  Future<bool> modifyDevice(bool link);

  Future<NetworkResult<VersionResponse?>> getDevice({String? fbToken});
}
