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
import 'package:mawaheb_app/features/players/data/models/partner_member_model.dart';

abstract class PlayersDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers(
      {@required String country,
      @required String sport,
      @required String position,
      @required String hand,
      @required String leg,
      @required String name});

  Future<NetworkResult<bool>> viewPlayerProfile({@required int id});

  Future<NetworkResult<bool>> bookPlayer(
      {@required int playerId, @required int partnerId});

  Future<NetworkResult<bool>> confirmPlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  });

  Future<NetworkResult<bool>> releasePlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  });

  Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
      getMemberShips({
    @required int partnerId,
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
    @required String name,
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
            // {'fieldName': 'blocked', 'operator': '=', 'value': false},
            // {'fieldName': 'status', 'operator': '=', 'value': 'INACTIVE'},
            // {'fieldName': 'availability', 'operator': '=', 'value': 'RELEASED'}
            if (name != '' && name != null)
              {'fieldName': 'name', 'operator': '=', 'value': name},

            if (country != '' && country != null)
              {'fieldName': 'country', 'operator': '=', 'value': country},

            if (sport != '' && sport != null)
              {'fieldName': 'sport', 'operator': '=', 'value': sport},

            if (position != '' && position != null)
              {'fieldName': 'position', 'operator': '=', 'value': position},
            if (hand != '' && hand != null)
              {'fieldName': 'hand', 'operator': '=', 'value': hand},
            if (leg != null && leg != '')
              {'fieldName': 'leg', 'operator': '=', 'value': leg}
          ],
          'operator': 'and'
        },
        'fields': ['name', 'id', 'photo']
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<bool>> viewPlayerProfile({@required int id}) {
    return mawahebRequest(
        method: METHOD.POST,
        mawahebModel: false,
        modelName: 'auth.db.User',
        action: EndPointAction.fetch,
        id: id,
        data: {
          'data': {
            'criteria': [],
            'operator': 'and',
            'operation': 'VIEW_PLAYER_PROFILE',
          },
          'fields': ['name', 'id']
        });
  }

  @override
  Future<NetworkResult<bool>> bookPlayer({int playerId, int partnerId}) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: 'Membership',
      data: {
        'data': {
          'partner': {'id': partnerId},
          'player': {'id': playerId},
          'status': 'BOOKED'
        }
      },
    );
  }

  @override
  Future<NetworkResult<bool>> confirmPlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  }) {
    return mawahebRequest(
        method: METHOD.POST,
        id: memberShipId,
        modelName: 'Membership',
        data: {
          'data': {'version': memberShipVersion, 'status': 'CONFIRMED'},
          'fields': ['partner', 'player', 'status', 'version']
        });
  }

  @override
  Future<NetworkResult<bool>> releasePlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  }) {
    return mawahebRequest(
        method: METHOD.POST,
        id: memberShipId,
        modelName: 'Membership',
        data: {
          'data': {'version': memberShipVersion, 'status': 'RELEASED'},
          'fields': ['partner', 'player', 'status', 'version']
        });
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
      getMemberShips({int partnerId}) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: 'Membership',
      action: EndPointAction.search,
      data: {
        'data': {
          'criteria': [
            {'fieldName': 'partner.id', 'operator': '=', 'value': partnerId},
            {'fieldName': 'status', 'operator': '=', 'value': 'CONFIRMED'}
          ],
          'operator': 'and'
        },
        'fields': ['version', 'player', 'status']
      },
      mapper: ListBaseResponseModel.fromJson(PartnerMemberModel.fromJson),
    );
  }
}
