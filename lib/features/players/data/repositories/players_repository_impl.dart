import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/data/datasources/players_datasource.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';

@LazySingleton(as: PlayersRepository)
class PlayersRepositoryImpl extends PlayersRepository {
  const PlayersRepositoryImpl(this.playersDataSource, this.prefsRepository)
      : super(playersDataSource);
  final PlayersDataSource playersDataSource;
  final PrefsRepository prefsRepository;

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers(
          {@required String country,
          @required String sport,
          @required String position,
          @required String hand,
          @required String leg,
          @required int partnerId,
          @required bool isConfirmed,
          @required bool isBooked,
          @required String name}) =>
      playersDataSource.searchPlayers(
          hand: hand,
          leg: leg,
          sport: sport,
          country: country,
          name: name,
          position: position,
          partnerId: partnerId,
          isConfirmed: isConfirmed,
          isBooked: isBooked);

  @override
  Future<NetworkResult<bool>> viewPlayerProfile({int id}) =>
      playersDataSource.viewPlayerProfile(id: id);

  @override
  Future<NetworkResult<bool>> bookPlayer({
    int playerId,
  }) =>
      playersDataSource.bookPlayer(
          playerId: playerId, partnerId: prefsRepository.player.id);

  @override
  Future<NetworkResult<bool>> confirmPlayer(
          {int memberShipId, int memberShipVersion}) =>
      playersDataSource.confirmPlayer(
          memberShipId: memberShipId, memberShipVersion: memberShipVersion);

  @override
  Future<NetworkResult<bool>> releasePlayer(
          {int memberShipId, int memberShipVersion}) =>
      playersDataSource.releasePlayer(
          memberShipId: memberShipId, memberShipVersion: memberShipVersion);

  // @override
  // Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
  //     getMemberShips({int partnerId}) =>
  //         playersDataSource.getMemberShips(partnerId: partnerId);
}
