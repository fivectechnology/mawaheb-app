import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/players/domain/repositiories/players_repository.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';

part 'players_viewmodel.g.dart';

@injectable
class PlayersViewmodel extends _PlayersViewmodelBase with _$PlayersViewmodel {
  PlayersViewmodel(
    Logger logger,
    PlayersRepository playersRepository,
    AuthRepository authRepository,
    ProfileRepository profileRepository,
    PrefsRepository prefsRepository,
  ) : super(logger, playersRepository, authRepository, profileRepository,
            prefsRepository);
}

abstract class _PlayersViewmodelBase extends BaseViewmodel with Store {
  _PlayersViewmodelBase(Logger logger, this._playersRepository,
      this._authRepository, this._profileRepository, this.prefsRepository)
      : super(logger);
  final PlayersRepository _playersRepository;
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final PrefsRepository prefsRepository;

  //* OBSERVERS *//
  @observable
  ObservableFuture<bool> viewProfileFuture;

  @observable
  ObservableFuture<List<VideoModel>> fetchVideoFuture;

  @observable
  ObservableFuture<bool> bookPlayerFuture;

  @observable
  ObservableFuture<bool> confirmPlayerFuture;

  @observable
  ObservableFuture<bool> releasePlayerFuture;

  @observable
  bool booked = false;

  @observable
  bool confirmed = false;

  @observable
  int playerId;

  @observable
  String playerName;

  @observable
  String searchName;

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
  ObservableFuture<List<PlayerModel>> playersFuture;

  @observable
  ObservableFuture<List<SportModel>> sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>> positionFuture;

  @observable
  ObservableFuture<List<CountryModel>> countryFuture;

  @observable
  ObservableFuture<PlayerModel> playerFuture;

  // @observable
  // ObservableFuture<List<PartnerMemberModel>> membersFuture;

  @computed
  bool get viewProfileLoading => viewProfileFuture?.isPending ?? false;

  @computed
  List<VideoModel> get videos => fetchVideoFuture?.value;

  @computed
  bool get videosLoading => fetchVideoFuture?.isPending ?? false;

  @computed
  bool get viewProfileError => viewProfileFuture?.isFailure ?? false;

  @computed
  bool get bookPlayerLoading => bookPlayerFuture?.isPending ?? false;

  @computed
  bool get bookPlayerError => bookPlayerFuture?.isFailure ?? false;

  @computed
  bool get confirmPlayerLoading => confirmPlayerFuture?.isPending ?? false;

  @computed
  bool get confirmPlayerError => confirmPlayerFuture?.isFailure ?? false;

  @computed
  bool get releasePlayerLoading => releasePlayerFuture?.isPending ?? false;

  @computed
  bool get releasePlayerError => releasePlayerFuture?.isFailure ?? false;

  //* COMPUTED *//

  @computed
  SportModel get filterCountry => sport;

  @computed
  SportModel get filterPosition => sport;

  @computed
  List<PlayerModel> get players => playersFuture?.value;

  @computed
  bool get getPlayers => playersFuture?.isPending ?? false;

  // @computed
  // List<PartnerMemberModel> get members => membersFuture?.value;

  @computed
  List<SportModel> get sports => sportFuture?.value;

  @computed
  List<CountryModel> get countries => countryFuture?.value;

  @computed
  List<SportPositionModel> get positions => positionFuture?.value;

  @computed
  PlayerModel get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  // @computed
  // bool get playerLoading => playersFuture?.value ?? false;

  //* ACTIONS *//
  @action
  void fetchPlayer({int id}) => playerFuture = futureWrapper(
        () => _profileRepository
            .fetchPlayer(id: id)
            .whenSuccess((res) => res.data.first.apply(() async {})),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

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
    int countryId,
    int sportId,
    int positionId,
    String hand,
    String name,
    String leg,
  }) =>
      playersFuture = futureWrapper(
        () => _playersRepository
            .searchPlayers(
              name: name,
              positionId: positionId ?? 0,
              countryId: countryId ?? 0,
              sportId: sportId ?? 0,
              leg: leg,
              isBooked: booked,
              isConfirmed: confirmed,
              partnerId: prefsRepository?.player?.id ?? 0,
              hand: hand,
            )
            .whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  // @action
  // void getMembers({int partnerId}) => membersFuture = futureWrapper(
  //       () => _playersRepository
  //           .getMemberShips(partnerId: partnerId)
  //           .whenSuccess((res) => res.data),
  //       catchBlock: (err) => showSnack(err, duration: 2.seconds),
  //     );

  @action
  void viewProfilePlayer({
    @required int id,
  }) {
    viewProfileFuture = futureWrapper(
      () => _playersRepository.viewPlayerProfile(id: id).whenSuccess(
            (res) => res.apply(() {
              print('view profile');
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void bookPlayer({@required int playerId}) {
    bookPlayerFuture = futureWrapper(
      () => _playersRepository.bookPlayer(playerId: playerId).whenSuccess(
            (res) => res.apply(() {
              print('player ${player.name} booked');
              fetchPlayer(id: player.id);
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void confirmPlayer() {
    confirmPlayerFuture = futureWrapper(
      () => _playersRepository
          .confirmPlayer(
              memberShipId: player.membership.id,
              memberShipVersion: player.membership.$version)
          .whenSuccess(
            (res) => res.apply(() {
              print('player ${player.name} confirmed');
              fetchPlayer(id: player.id);
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void releasePlayer() {
    releasePlayerFuture = futureWrapper(
      () => _playersRepository
          .releasePlayer(
              memberShipId: player.membership.id,
              memberShipVersion: player.membership.$version)
          .whenSuccess(
            (res) => res.apply(() {
              print('player ${player.name} released');
              fetchPlayer(id: player.id);
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void fetchVideos({int playerId}) {
    fetchVideoFuture = futureWrapper(
      () =>
          _profileRepository.fetchPlayerVideos(playerId: playerId).whenSuccess(
                (res) => res.data.apply(() {
                  print('fetch videos');
                }),
              ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
