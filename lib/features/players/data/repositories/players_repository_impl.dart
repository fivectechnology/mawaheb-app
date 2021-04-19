import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/data/datasources/players_datasource.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';

@LazySingleton(as: PlayersRepository)
class PlayersRepositoryImpl extends PlayersRepository {
  const PlayersRepositoryImpl(this.playersDataSource)
      : super(playersDataSource);
  final PlayersDataSource playersDataSource;

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> searchPlayers({
    @required String country,
    @required String sport,
    @required String position,
    @required String hand,
    @required String leg,
  }) =>
      playersDataSource.searchPlayers();

  @override
  Future<NetworkResult<bool>> viewPlayerProfile({int id}) =>
      playersDataSource.viewPlayerProfile(id: id);
}
