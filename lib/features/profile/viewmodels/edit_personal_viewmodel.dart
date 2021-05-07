import 'dart:io';

import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mawaheb_app/features/profile/ui/pages/edits/edit_personal_page.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:supercharged/supercharged.dart';

part 'edit_personal_viewmodel.g.dart';

@injectable
class EditPersonalViewmodel extends _EditPersonalViewmodelBase
    with _$EditPersonalViewmodel {
  EditPersonalViewmodel(Logger logger, ProfileRepository _profileRepository,
      PrefsRepository prefsRepository, AuthRepository _authRepository)
      : super(logger, _profileRepository, _authRepository, prefsRepository);
}

abstract class _EditPersonalViewmodelBase extends BaseViewmodel with Store {
  _EditPersonalViewmodelBase(Logger logger, this._profileRepository,
      this._authRepository, this.prefsRepository)
      : super(logger);
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;

//* OBSERVERS *//

  @observable
  Future<int> imageId;

  @observable
  File image;

  @observable
  ObservableFuture<PlayerModel> playerFuture;

  @observable
  ObservableFuture<List<CategoryModel>> categoryFuture;

  @observable
  ObservableFuture<List<CountryModel>> countryFuture;

  @computed
  List<CategoryModel> get categories => categoryFuture?.value;

  @computed
  List<CountryModel> get positions => countryFuture?.value;

  @computed
  bool get countryLoading => countryFuture?.isPending ?? false;

  @computed
  bool get categoryLoading => categoryFuture?.isPending ?? false;

  @observable
  ObservableFuture<PlayerModel> editPersonalPlayerFuture;

  @computed
  File get imageFile => image;

//* COMPUTED *//
  @computed
  PlayerModel get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

//* ACTIONS *//

  @action
  void getCategories() => categoryFuture = futureWrapper(
        () => _authRepository.getCategories().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res.data),
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
  // ignore: missing_return
  Future<int> uploadImage({
    int playerId,
    int playerVersion,
    File file,
    int fileSize,
    String fileName,
    String fileType,
  }) {
    imageId = _profileRepository.uploadFile(file: file).then((res1) async {
      final res = res1.getOrThrow();
      print('file upoladed');

      await _profileRepository
          .updateImageProfile(
              imageId: res, version: playerVersion + 1, id: playerId)
          .whenSuccess((res) => apply(() {
                print('image updated');
                Navigator.of(EditPersonalPage.keyLoader.currentContext,
                        rootNavigator: true)
                    .pop();
                getContext((context) => App.navKey.currentState.context
                    .pushNamedAndRemoveUntil(BasePage.route, (_) => false));
              }));
      // updateProfileImage(
      //     id: player.id, version: player.version, imageId: await imageId);
      return res;
    });
  }

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
              id: player.id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res.data.first.apply(() {
              if (image == null) {
                getContext((context) => App.navKey.currentState.context
                    .pushNamedAndRemoveUntil(BasePage.route, (_) => false));
              }
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
