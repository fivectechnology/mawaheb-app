import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'edit_sport_viewmodel.g.dart';

@injectable
class EditSportViewmodel extends _EditSportViewmodelBase with _$EditSportViewmodel {
  EditSportViewmodel(Logger logger, ProfileRepository _profileRepository, PrefsRepository prefsRepository,
      AuthRepository _authRepository)
      : super(logger, _profileRepository, _authRepository, prefsRepository);
}

abstract class _EditSportViewmodelBase extends BaseViewmodel with Store {
  _EditSportViewmodelBase(Logger logger, this._profileRepository, this._authRepository, this.prefsRepository)
      : super(logger);
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;

//* OBSERVERS *//
  @observable
  ObservableFuture<PlayerModel>? playerFuture;

  @observable
  ObservableFuture<List<SportModel>>? sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>>? positionFuture;

  //* COMPUTED *//
  @computed
  PlayerModel? get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  @computed
  List<SportModel>? get sports => sportFuture?.value;

  @computed
  List<SportPositionModel>? get positions => positionFuture?.value;

  @computed
  bool get positionsLoading => positionFuture?.isPending ?? false;

  @computed
  bool get sportLoading => sportFuture?.isPending ?? false;

  //* ACTIONS *//

  @observable
  ObservableFuture<PlayerModel>? editSportPlayerFuture;

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res!.data ?? []),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getPositions({required int? sportId}) => positionFuture = futureWrapper(
        () => _authRepository.getPositions(sportId: sportId).whenSuccess((res) => res!.data ?? []),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void fetchPlayer({int? id}) => playerFuture = futureWrapper(
        () => _profileRepository.fetchPlayer(id: id).whenSuccess((res) => res!.data!.first),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void editSportInfo(
      {int? weight,
      int? height,
      String? hand,
      String? leg,
      String? brief,
      SportModel? sport,
      SportPositionModel? position}) {
    playerFuture = futureWrapper(
      () => _profileRepository
          .updateSportInfo(
              version: playerFuture!.value!.version,
              id: playerFuture!.value!.id,
              weight: weight,
              height: height,
              hand: hand,
              leg: leg,
              brief: brief,
              sport: sport,
              sportPositionModel: position)
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              getContext((context) => context.pop(true));
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }
}
