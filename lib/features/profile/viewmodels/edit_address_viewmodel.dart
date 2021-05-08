import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'edit_address_viewmodel.g.dart';

@injectable
class EditAddressViewmodel extends _EditAddressViewmodelBase
    with _$EditAddressViewmodel {
  EditAddressViewmodel(Logger logger, ProfileRepository _profileRepository,
      PrefsRepository prefsRepository, AuthRepository _authRepository)
      : super(logger, _profileRepository, _authRepository, prefsRepository);
}

abstract class _EditAddressViewmodelBase extends BaseViewmodel with Store {
  _EditAddressViewmodelBase(Logger logger, this._profileRepository,
      this._authRepository, this.prefsRepository)
      : super(logger);
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;

//* OBSERVERS *//
  @observable
  ObservableFuture<PlayerModel> playerFuture;

  @observable
  ObservableFuture<List<EmirateModel>> emirateFuture;

  @computed
  List<EmirateModel> get emirates => emirateFuture?.value;

  @computed
  bool get emiratesLoading => emirateFuture?.isPending ?? false;

  @observable
  ObservableFuture<PlayerModel> editAddressPlayerFuture;

//* COMPUTED *//
  @computed
  PlayerModel get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  @computed
  bool get addressLoading => editAddressPlayerFuture?.isPending ?? false;

//* ACTIONS *//

  @action
  void getEmirates() => emirateFuture = futureWrapper(
        () => _authRepository.getEmirates().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void fetchPlayer({int id}) => playerFuture = futureWrapper(
        () => _profileRepository
            .fetchPlayer(id: id)
            .whenSuccess((res) => res.data.first.apply(() async {
                  // if (prefsRepository.player == null) {
                  //   await prefsRepository.setPlayer(res.data.first);
                  // }
                })),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void editAddressInfo(
      {String address, String area, EmirateModel emirateModel}) {
    editAddressPlayerFuture = futureWrapper(
      () => _authRepository
          .addAddressInfo(
            version: player.version,
            id: player.id,
            emirateModel: emirateModel,
            area: area,
            address: address,
          )
          .whenSuccess(
            (res) => res.data.first.apply(() {
              getContext((context) => context.pop());
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
