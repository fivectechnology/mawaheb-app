import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

import 'mawaheb_datasource.dart';

abstract class AppDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<int>>> getNotificationsCount();

  Future<NetworkResult<BaseResponseModel<Object>>> deleteDevice(
      {String firebaseToken});

  Future<NetworkResult<VersionResponse>> registerDevice({
    String firebaseToken,
    String appVersion,
    String deviceModel,
    String deviceUuid,
    String osTypeId,
    String osVersion,
    int appTypeId,
  });

  Future<NetworkResult<VersionResponse>> modifyDevice(bool link);

  Future<NetworkResult<VersionResponse>> getDevice({String fbToken});
}

@LazySingleton(as: AppDataSource)
class AppDataSourceImpl extends MawahebRemoteDataSource
    implements AppDataSource {
  AppDataSourceImpl({
    @required Dio client,
    @required PrefsRepository prefsRepository,
    @required DataConnectionChecker connectionChecker,
    @required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          connectionChecker: connectionChecker,
          logger: logger,
        );

  @override
  Future<NetworkResult<ListBaseResponseModel<int>>> getNotificationsCount() =>
      mawahebRequest(
          method: METHOD.POST,
          modelName: 'NotificationMessage',
          mapper: ListBaseResponseModel.fromJson((obj) => obj as int),
          data: {
            'fields': ['id', 'version', 'code', 'value'],
            'data': {'_domain': 'self.recordId =:__user__'},
            'limit': 1,
            'offset': 0
          });

  @override
  Future<NetworkResult<VersionResponse>> registerDevice({
    String firebaseToken,
    String appVersion,
    String deviceModel,
    String deviceUuid,
    String osTypeId,
    String osVersion,
    int appTypeId,
  }) =>
      mawahebRequest(
        modelName: 'NotificationDevice',
        method: METHOD.POST,
        mapper: BaseResponseModel.versionMapper,
        data: {
          'data': {
            'deviceId': firebaseToken,
            'appTypeId': appTypeId,
            'appVersion': appVersion,
            'deviceModel': deviceModel,
            'deviceUuid': deviceUuid,
            'osTypeId': osTypeId,
            'osVersion': osVersion,
          }
        },
      );

  @override
  Future<NetworkResult<BaseResponseModel<Object>>> deleteDevice(
          {String firebaseToken}) =>
      mawahebRequest(
        method: METHOD.POST,
        modelName: 'NotificationDevice',
        mapper: BaseResponseModel.fromJson((obj) => obj),
        data: firebaseToken,
        withAuth: false,
      );

  @override
  Future<NetworkResult<VersionResponse>> modifyDevice(bool link) async {
    final version = (await getDevice()).getOrThrow().version;
    logger.d('version in modify device is $version');
    return mawahebRequest(
        method: METHOD.POST,
        modelName: 'NotificationDevice',
        mapper: ListBaseResponseModel.versionMapper,
        data: {
          'fields': ['id', 'version', 'deviceId'],
          'data': {
            'id': prefsRepository.fbId,
            'version': version,
            'user': link ? {'id': prefsRepository.player.id} : null,
          }
        });
  }

  @override
  Future<NetworkResult<VersionResponse>> getDevice({String fbToken}) =>
      mawahebRequest(
        method: METHOD.POST,
        modelName: 'NotificationDevice',
        id: fbToken == null ? prefsRepository.fbId : null,
        action: fbToken == null ? EndPointAction.fetch : EndPointAction.search,
        mapper: ListBaseResponseModel.versionMapper,
        data: fbToken == null
            ? VersionResponse.body
            : {
                'fields': ['id', 'version', 'deviceId'],
                'data': {
                  'criteria': [
                    {
                      'fieldName': 'deviceId',
                      'operator': '=',
                      'value': fbToken,
                    }
                  ]
                },
                'limit': 1,
                'offset': 0
              },
      );
}
