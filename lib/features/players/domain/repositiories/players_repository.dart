import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/players/data/datasources/players_datasource.dart';

abstract class PlayersRepository extends BaseRepository {
  const PlayersRepository(PlayersDataSource playersDataSource) : super(playersDataSource);
}
