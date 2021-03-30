import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/players/data/datasources/players_datasource.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';

@LazySingleton(as: PlayersRepository)
class PlayersRepositoryImpl extends PlayersRepository {
  const PlayersRepositoryImpl(this.playersDataSource) : super(playersDataSource);
  final PlayersDataSource playersDataSource;
}
