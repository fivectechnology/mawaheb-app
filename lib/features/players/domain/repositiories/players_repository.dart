import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/data/datasources/players_datasource.dart';
import 'package:mawaheb_app/features/players/data/models/partner_member_model.dart';

abstract class PlayersRepository extends BaseRepository {
  const PlayersRepository(PlayersDataSource playersDataSource)
      : super(playersDataSource);

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers({
    @required String country,
    @required String sport,
    @required String position,
    @required String hand,
    @required String leg,
    @required String name,
    @required int partnerId,
    @required bool isConfirmed,
    @required bool isBooked,
  });

  Future<NetworkResult<bool>> viewPlayerProfile({@required int id});

  Future<NetworkResult<bool>> bookPlayer({int playerId});

  Future<NetworkResult<bool>> confirmPlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  });

  Future<NetworkResult<bool>> releasePlayer({
    @required int memberShipId,
    @required int memberShipVersion,
  });

  // Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
  //     getMemberShips({int partnerId});
}
