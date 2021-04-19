import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';

part 'players_viewmodel.g.dart';

@injectable
class PlayersViewmodel extends _PlayersViewmodelBase with _$PlayersViewmodel {
  PlayersViewmodel(
    Logger logger,
    PlayersRepository playersRepository,
    AuthRepository authRepository,
  ) : super(logger, playersRepository, authRepository);
}

abstract class _PlayersViewmodelBase extends BaseViewmodel with Store {
  _PlayersViewmodelBase(
      Logger logger, this._playersRepository, this._authRepository)
      : super(logger);
  final PlayersRepository _playersRepository;
  final AuthRepository _authRepository;

  //* OBSERVERS *//

  @observable
  SportModel sport;

  @observable
  CountryModel country;

  @observable
  SportPositionModel position;

  @observable
  String leg;

  @observable
  String hand;

  @observable
  bool confirmed = false;

  @observable
  ObservableFuture<List<PlayerModel>> playersFuture;

  @observable
  ObservableFuture<List<SportModel>> sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>> positionFuture;

  @observable
  ObservableFuture<List<CountryModel>> countryFuture;

  //* COMPUTED *//

  @computed
  bool get isConfirmed => confirmed;

  @computed
  SportModel get filterCountry => sport;

  @computed
  SportModel get filterPosition => sport;

  @computed
  List<PlayerModel> get players => playersFuture?.value;

  @computed
  List<SportModel> get sports => sportFuture?.value;

  @computed
  List<CountryModel> get countries => countryFuture?.value;

  @computed
  List<SportPositionModel> get positions => positionFuture?.value;

  // @computed
  // bool get playerLoading => playersFuture?.value ?? false;

  //* ACTIONS *//

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getPositions() => positionFuture = futureWrapper(
        () => _authRepository.getPositions().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void searchPlayers({
    @required String country,
    @required String sport,
    @required String position,
    @required String hand,
    @required String leg,
  }) =>
      playersFuture = futureWrapper(
        () => _playersRepository
            .searchPlayers(
                position: position,
                country: country,
                sport: sport,
                leg: leg,
                hand: hand)
            .whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );
}
