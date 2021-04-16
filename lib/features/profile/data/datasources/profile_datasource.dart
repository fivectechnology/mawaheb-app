import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

abstract class ProfileDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchProfile({
    @required int id,
  });
}

@LazySingleton(as: ProfileDataSource)
class ProfileDataSourceImpl extends MawahebRemoteDataSource
    implements ProfileDataSource {
  ProfileDataSourceImpl({
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
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchProfile(
      {int id}) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: false,
      modelName: 'auth.db.User',
      action: EndPointAction.fetch,
      withAuth: true,
      id: id,
      data: {
        'fields': [
          'country',
          'subscriptions',
          'currentSubscription',
          'videos',
          'type',
          'leg',
          'height',
          'area',
          'weight',
          'phone',
          'name',
          'position',
          'status',
          'gender',
          'brief',
          'hand',
          'address',
          'dateOfBirth',
          'emirate',
          'category',
          'sport',
          'viewers'
        ]
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }
}
