import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationsDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<BaseResponseModel<Object>>> markAsRead({int notificationId});

  Future<NetworkResult<ListBaseResponseModel<NotificationModel>>> getNotifications({
    @required int limit,
    @required int offset,
  });
}

@LazySingleton(as: NotificationsDataSource)
class NotificationsDataSourceImpl extends MawahebRemoteDataSource implements NotificationsDataSource {
  NotificationsDataSourceImpl({
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
  Future<NetworkResult<ListBaseResponseModel<NotificationModel>>> getNotifications({
    @required int limit,
    @required int offset,
  }) =>
      mawahebRequest(
          method: METHOD.POST,
          modelName: 'NotificationMessage',
          action: EndPointAction.search,
          mapper: ListBaseResponseModel.fromJson(NotificationModel.fromJson),
          data: {
            'fields': ['id', 'version', 'readDate', 'recordId', 'sendDate', 'type', 'template', 'params'],
            'sortBy': ['-sendDate'],
            'data': {'_domain': 'self.user =:__user__'},
            'limit': limit,
            'offset': offset
          });

  @override
  Future<NetworkResult<BaseResponseModel<Object>>> markAsRead({int notificationId}) async => mawahebRequest(
        method: METHOD.POST,
        modelName: 'NotificationMessage',
        mapper: BaseResponseModel.fromJson((obj) => obj),
        data: {
          'fields': ['version', 'readDate'],
          'data': {
            'id': notificationId,
            'version': await getVersion(modelId: notificationId, modelName: 'NotificationMessage'),
            'readDate': DateTime.now(),
          }
        },
      );
}
