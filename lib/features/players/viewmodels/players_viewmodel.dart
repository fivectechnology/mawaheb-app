import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';
import 'package:mobx/mobx.dart';

part 'players_viewmodel.g.dart';

@injectable
class PlayersViewmodel extends _PlayersViewmodelBase with _$PlayersViewmodel {
  PlayersViewmodel(
    Logger logger,
    PlayersRepository playersRepository,
  ) : super(logger, playersRepository);
}

abstract class _PlayersViewmodelBase extends BaseViewmodel with Store {
  _PlayersViewmodelBase(Logger logger, this._playersRepository) : super(logger);
  final PlayersRepository _playersRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
