import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

abstract class PlayersDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers({
    @required String country,
    @required String sport,
    @required String position,
    @required String hand,
    @required String leg,
  });
}

@LazySingleton(as: PlayersDataSource)
class PlayersDataSourceImpl extends MawahebRemoteDataSource
    implements PlayersDataSource {
  PlayersDataSourceImpl({
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
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers({
    @required String country,
    @required String sport,
    @required String position,
    @required String hand,
    @required String leg,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: false,
      modelName: 'auth.db.User',
      action: EndPointAction.search,
      data: {
        'data': {
          'criteria': [
            {'fieldName': 'type', 'operator': '=', 'value': 'PLAYER'},
            {'fieldName': 'blocked', 'operator': '=', 'value': false},
            {'fieldName': 'status', 'operator': '=', 'value': 'INACTIVE'},
            {'fieldName': 'availability', 'operator': '=', 'value': 'RELEASED'}
            // {'fieldName': 'country', 'operator': '=', 'value': ''},
            // {'fieldName': 'sport', 'operator': '=', 'value': ''},
            // {'fieldName': 'position', 'operator': '=', 'value': ''},
            // {'fieldName': 'hand', 'operator': '=', 'value': ''},
            // {'fieldName': 'leg', 'operator': '=', 'value': ''}
          ],
          'operator': 'and'
        },
        'fields': [
          'name',
        ]
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }
}
