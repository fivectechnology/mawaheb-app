import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/players/data/models/player_filter_model.dart';
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
  ) : super(logger, playersRepository, authRepository, profileRepository, prefsRepository);
}

abstract class _PlayersViewmodelBase extends BaseViewmodel with Store {
  _PlayersViewmodelBase(
    Logger logger,
    this._playersRepository,
    this._authRepository,
    this._profileRepository,
    this.prefsRepository,
  ) : super(logger) {
    searchPlayers(fresh: true);
    getCountries();
    getPositions();
    getSports();
  }
  final PlayersRepository _playersRepository;
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final PrefsRepository prefsRepository;

  //* OBSERVERS *//
  @observable
  ObservableFuture<bool>? viewProfileFuture;

  @observable
  ObservableFuture<List<VideoModel>>? fetchVideoFuture;

  @observable
  ObservableFuture<ListBaseResponseModel<PlayerModel>>? playersFuture;

  @observable
  ObservableFuture<bool>? bookPlayerFuture;

  @observable
  ObservableFuture<bool>? confirmPlayerFuture;

  @observable
  ObservableFuture<bool>? releasePlayerFuture;

  @observable
  PlayerFilterModel? filter = PlayerFilterModel.initial();

  @observable
  ObservableFuture<List<SportModel>>? sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>>? positionFuture;

  @observable
  ObservableFuture<List<CountryModel>>? countryFuture;

  @observable
  ObservableFuture<PlayerModel>? playerFuture;

  // @observable
  // ObservableFuture<List<PartnerMemberModel>> membersFuture;

  //* COMPUTED *//

  @computed
  ListBaseResponseModel<PlayerModel>? get players => playersFuture?.value;

  @computed
  bool get getPlayers => playersFuture?.isPending ?? false;

  @computed
  List<SportModel>? get sports => sportFuture?.value;

  @computed
  List<CountryModel>? get countries => countryFuture?.value;

  @computed
  List<SportPositionModel>? get positions => positionFuture?.value;

  @computed
  PlayerModel? get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  @computed
  bool get viewProfileLoading => viewProfileFuture?.isPending ?? false;

  @computed
  List<VideoModel>? get videos => fetchVideoFuture?.value;

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

  @computed
  bool get statusButtonLoading => bookPlayerLoading || confirmPlayerLoading || releasePlayerLoading || playerLoading;

  @computed
  bool get canLoadMorePlayers {
    if (players == null) {
      return true;
    }
    if (players!.offset! + PAGE_SIZE < players!.total!) {
      return true;
    }

    return false;
  }

  //* ACTIONS *//
  @action
  void fetchPlayer({int? id}) => playerFuture = futureWrapper(
        () => _profileRepository.fetchPlayer(id: id).whenSuccess((res) => res?.data!.first.apply(() async {})),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getPositions() => positionFuture = futureWrapper(
        () => _authRepository.getPositions().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void searchPlayers({bool fresh = false, String? query}) {
    if (fresh || canLoadMorePlayers) {
      int offset = (players?.offset ?? -PAGE_SIZE) + PAGE_SIZE;
      if (fresh) {
        playersFuture = null;
        offset = 0;
      }

      final ObservableFuture<ListBaseResponseModel<PlayerModel>> future = futureWrapper(
        () => _playersRepository
            .searchPlayers(
              offset: offset,
              limit: PAGE_SIZE,
              name: query,
              positionId: filter?.positionId ?? 0,
              countryId: filter?.countryId ?? 0,
              sportId: filter?.sportId ?? 0,
              leg: filter?.leg,
              isBooked: filter?.isBooked ?? false,
              isConfirmed: filter?.isConfirmed ?? false,
              hand: filter?.hand,
              partnerId: prefsRepository.player?.id ?? 0,
            )
            .replace(oldValue: playersFuture, onSuccess: () {}),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
        unknownErrorHandler: (err) => showSnack(err, duration: 2.seconds),
      );
      playersFuture = playersFuture?.replace(future) ?? future;
    }
  }

  // @action
  // void getMembers({int partnerId}) => membersFuture = futureWrapper(
  //       () => _playersRepository
  //           .getMemberShips(partnerId: partnerId)
  //           .whenSuccess((res) => res.data),
  //       catchBlock: (err) => showSnack(err, duration: 2.seconds),
  //     );

  @action
  void viewProfilePlayer({
    required int? id,
  }) {
    viewProfileFuture = futureWrapper(
      () => _playersRepository.viewPlayerProfile(id: id).whenSuccess((res) => res ?? false),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void bookPlayer() {
    bookPlayerFuture = futureWrapper(
      () => _playersRepository.bookPlayer(playerId: player!.id).whenSuccess(
            (res) => res?.apply(() {
              print('player ${player!.name} booked');
              fetchPlayer(id: player!.id);
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void confirmPlayer() {
    confirmPlayerFuture = futureWrapper(
      () => _playersRepository
          .confirmPlayer(memberShipId: player!.membership!.id, memberShipVersion: player!.membership!.$version)
          .whenSuccess(
            (res) => res?.apply(() {
              print('player ${player!.name} confirmed');
              fetchPlayer(id: player!.id);
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void releasePlayer() {
    releasePlayerFuture = futureWrapper(
      () => _playersRepository
          .releasePlayer(memberShipId: player!.membership!.id, memberShipVersion: player!.membership!.$version)
          .whenSuccess(
            (res) => res?.apply(() {
              print('player ${player!.name} released');
              fetchPlayer(id: player!.id);
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void fetchVideos({int? playerId}) {
    fetchVideoFuture = futureWrapper(
      () => _playersRepository.fetchApprovedVideos(playerId: playerId).whenSuccess((res) => res?.data ?? []),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void changePlayerFilter({
    CountryModel? country,
    SportModel? sport,
    SportPositionModel? position,
    String? hand,
    String? leg,
    String? name,
    int? partnerId,
    bool? isConfirmed,
    bool? isBooked,
  }) {
    filter = filter!.copyWith(
      country: country,
      sport: sport,
      position: position,
      hand: hand,
      leg: leg,
      name: name,
      partnerId: partnerId,
      isConfirmed: isConfirmed,
      isBooked: isBooked,
    );
  }

  // @action
  // void changePlayerFilter({
  //   CountryModel country,
  //   SportModel sport,
  //   SportPositionModel position,
  //   String hand,
  //   String leg,
  //   String name,
  //   int partnerId,
  //   bool isConfirmed,
  //   bool isBooked,
  // }) {
  //   filter = filter.copyWith(
  //     country: country,
  //     sport: sport,
  //     position: position,
  //     hand: hand,
  //     leg: leg,
  //     name: name,
  //     partnerId: partnerId,
  //     isConfirmed: isConfirmed,
  //     isBooked: isBooked,
  //   );
  // }
}
