import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/players/ui/pages/videos_page.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mawaheb_app/features/profile/ui/pages/my_info_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/view_page.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';

part 'profile_viewmodel.g.dart';

@injectable
class ProfileViewmodel extends _ProfileViewmodelBase with _$ProfileViewmodel {
  ProfileViewmodel(Logger logger, ProfileRepository profileRepository,
      AuthRepository authRepository, PrefsRepository prefsRepository)
      : super(logger, profileRepository, authRepository, prefsRepository);
}

abstract class _ProfileViewmodelBase extends BaseViewmodel with Store {
  _ProfileViewmodelBase(Logger logger, this._profileRepository,
      this._authRepository, this.prefsRepository)
      : super(logger);
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;

  List<Widget> pages = [
    MyInfoPage(),
    const VideosPage(),
    const ViewsPage(),
  ];

  //* OBSERVERS *//

  @observable
  ObservableFuture<PlayerModel> playerFuture;

  @observable
  ObservableFuture<PlayerModel> editAddressPlayerFuture;

  @observable
  ObservableFuture<PlayerModel> editPersonalPlayerFuture;

  @observable
  ObservableFuture<PlayerModel> editSportPlayerFuture;

  @observable
  ObservableFuture<List<CategoryModel>> categoryFuture;

  @observable
  ObservableFuture<List<SportModel>> sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>> positionFuture;

  @observable
  ObservableFuture<List<CountryModel>> countryFuture;

  @observable
  ObservableFuture<List<EmirateModel>> emirateFuture;

  @observable
  ObservableFuture<List<ViewModel>> viewsFuture;

  //* COMPUTED *//
  @computed
  PlayerModel get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  @computed
  List<CategoryModel> get categories => categoryFuture?.value;

  @computed
  List<SportModel> get sports => sportFuture?.value;

  @computed
  List<CountryModel> get countries => countryFuture?.value;

  @computed
  List<SportPositionModel> get positions => positionFuture?.value;

  List<EmirateModel> get emirates => emirateFuture?.value;

  List<ViewModel> get views => viewsFuture?.value;

  //* ACTIONS *//

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getPostions() => positionFuture = futureWrapper(
        () => _authRepository.getPositions().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCategories() => categoryFuture = futureWrapper(
        () => _authRepository.getCategories().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getEmirates() => emirateFuture = futureWrapper(
        () => _authRepository.getEmirates().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void playerViews() => viewsFuture = futureWrapper(
        () => _profileRepository.playerViews().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void fetchPlayer({int id}) => playerFuture = futureWrapper(
        () => _profileRepository
            .fetchPlayer(id: id)
            .whenSuccess((res) => res.data.first.apply(() async {
                  if (prefsRepository.player == null) {
                    await prefsRepository.setPlayer(res.data.first);
                  }
                })),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void editPersonalInfo({
    String dateOfBirth,
    String gender,
    String name,
    String phone,
    CountryModel country,
    CategoryModel categoryModel,
    int id,
  }) {
    editPersonalPlayerFuture = futureWrapper(
      () => _authRepository
          .addPersonalInfo(
              version: player.version,
              id: id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res.data.first.apply(() {}),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

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
              getContext((context) => context.pushNamedAndRemoveUntil(
                  BasePage.route, (_) => false));
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void editSportInfo(
      {int weight,
      int height,
      String hand,
      String leg,
      String brief,
      SportModel sport,
      SportPositionModel position}) {
    playerFuture = futureWrapper(
      () => _authRepository
          .addSportInfo(
              version: playerFuture.value.version,
              id: playerFuture.value.id,
              weight: weight,
              height: height,
              hand: hand,
              leg: leg,
              brief: brief,
              sport: sport,
              sportPositionModel: position)
          .whenSuccess(
            (res) => res.data.first.apply(() {}),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
