import 'dart:async';
import 'dart:io';

import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mawaheb_app/features/profile/ui/pages/edits/edit_personal_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/my_info_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/static_videos_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/view_page.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:mawaheb_app/features/profile/ui/pages/videos_page.dart';

part 'profile_viewmodel.g.dart';

@injectable
class ProfileViewmodel extends _ProfileViewmodelBase with _$ProfileViewmodel {
  ProfileViewmodel(Logger logger, ProfileRepository profileRepository, AuthRepository authRepository,
      PrefsRepository prefsRepository)
      : super(logger, profileRepository, authRepository, prefsRepository);
}

abstract class _ProfileViewmodelBase extends BaseViewmodel with Store {
  _ProfileViewmodelBase(Logger logger, this._profileRepository, this._authRepository, this.prefsRepository)
      : super(logger);
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;

  List<Widget> pages = [
    const MyInfoPage(),
    const VideosPage(),
    const ViewsPage(),
    const StaticVideosPage(),
  ];

  //* OBSERVERS *//
  @observable
  File? image;

  @observable
  Future<int>? imageId;

  @observable
  ObservableFuture<PlayerModel>? playerFuture;

  @observable
  ObservableFuture<List<VideoModel>>? fetchVideoFuture;

  @observable
  ObservableFuture<PlayerModel>? editAddressPlayerFuture;

  @observable
  ObservableFuture<PlayerModel>? editPersonalPlayerFuture;

  @observable
  ObservableFuture<PlayerModel>? editSportPlayerFuture;

  @observable
  ObservableFuture<List<CategoryModel>>? categoryFuture;

  @observable
  ObservableFuture<List<SportModel>>? sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>>? positionFuture;

  @observable
  List<SportPositionModel> tempPositionFuture = [];

  @observable
  ObservableFuture<List<CountryModel>>? countryFuture;

  @observable
  ObservableFuture<List<EmirateModel>>? emirateFuture;

  @observable
  ObservableFuture<ListBaseResponseModel<ViewModel>>? viewsFuture;

  @observable
  ObservableFuture<bool>? uploadImageFuture;

  @observable
  ObservableFuture<bool>? deleteVideoFuture;

  @observable
  ObservableFuture<bool>? replaceVideoFuture;

  //* COMPUTED *//
  @computed
  PlayerModel? get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  @computed
  List<VideoModel> get videos => fetchVideoFuture?.value ?? [];

  @computed
  bool get videosLoading => fetchVideoFuture?.isPending ?? false;

  @computed
  List<CategoryModel>? get categories => categoryFuture?.value;

  @computed
  List<SportModel>? get sports => sportFuture?.value;

  @computed
  List<CountryModel>? get countries => countryFuture?.value;

  @computed
  List<SportPositionModel>? get positions => positionFuture?.value;

  @computed
  bool get positionsLoading => positionFuture?.isPending ?? false;

  @computed
  bool get sportLoading => sportFuture?.isPending ?? false;

  @computed
  List<EmirateModel>? get emirates => emirateFuture?.value;

  @computed
  ListBaseResponseModel<ViewModel>? get views => viewsFuture?.value;

  @computed
  bool get deleteVideoLoading => deleteVideoFuture?.isPending ?? false;

  @computed
  bool get deleteVideoError => deleteVideoFuture?.isFailure ?? false;

  @computed
  bool get replaceVideoLoading => replaceVideoFuture?.isPending ?? false;

  @computed
  bool get replaceVideoError => replaceVideoFuture?.isFailure ?? false;

  @computed
  bool get personalLoading => editPersonalPlayerFuture?.isPending ?? false;

  @computed
  bool get addressLoading => editAddressPlayerFuture?.isPending ?? false;

  @computed
  File? get imageFile => image;

  @computed
  bool get canLoadMoreViews {
    if (views == null) {
      return true;
    }
    if (views!.offset! + PAGE_SIZE < views!.total!) {
      return true;
    }

    return false;
  }

  //* ACTIONS *//

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getPositions({required int sportId}) => positionFuture = futureWrapper(
        () => _authRepository.getPositions(sportId: sportId).whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getCategories() => categoryFuture = futureWrapper(
        () => _authRepository.getCategories().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getEmirates() => emirateFuture = futureWrapper(
        () => _authRepository.getEmirates().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void playerViews({bool fresh = false}) {
    if (fresh || canLoadMoreViews) {
      int offset = (views?.offset ?? -PAGE_SIZE) + PAGE_SIZE;
      if (fresh) {
        viewsFuture = null;
        offset = 0;
      }
      final ObservableFuture<ListBaseResponseModel<ViewModel>> future = futureWrapper(
        () => _profileRepository.playerViews(limit: PAGE_SIZE, offset: offset).replace(
              oldValue: viewsFuture,
              onSuccess: () {},
            ),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
        unknownErrorHandler: (err) => showSnack(err, duration: 2.seconds),
      );
      viewsFuture = viewsFuture?.replace(future) ?? future;
    }
  }

  @action
  void fetchPlayer({int? id}) => playerFuture = futureWrapper(
        () => _profileRepository.fetchPlayer(id: id).whenSuccess((res) => res!.data!.first.apply(() async {
              if (prefsRepository.player == null) {
                await prefsRepository.setPlayer(res.data!.first);
              }
            })),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void editPersonalInfo({
    String? dateOfBirth,
    String? gender,
    String? name,
    String? phone,
    CountryModel? country,
    CategoryModel? categoryModel,
    int? id,
  }) {
    editPersonalPlayerFuture = futureWrapper(
      () => _authRepository
          .addPersonalInfo(
              version: player!.version,
              id: player!.id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              if (image == null) {
                getContext((context) =>
                    App.navKey.currentState!.context.pushNamedAndRemoveUntil(BasePage.route, (_) => false));
              }
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void editAddressInfo({String? address, String? area, EmirateModel? emirateModel}) {
    editAddressPlayerFuture = futureWrapper(
      () => _authRepository
          .addAddressInfo(
            version: player!.version,
            id: player!.id,
            emirateModel: emirateModel,
            area: area,
            address: address,
          )
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              getContext(
                  (context) => App.navKey.currentState!.context.pushNamedAndRemoveUntil(BasePage.route, (_) => false));
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

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
              getContext(
                  (context) => App.navKey.currentState!.context.pushNamedAndRemoveUntil(BasePage.route, (_) => false));
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  // ignore: missing_return
  Future<int>? uploadImage({
    int? playerId,
    int? playerVersion,
    File? file,
    int? fileSize,
    String? fileName,
    String? fileType,
  }) {
    imageId = _profileRepository.uploadFile(file: file).then((res1) async {
      final res = res1.getOrThrow();
      print('file upoladed');

      await _profileRepository
          .updateImageProfile(imageId: res, version: playerVersion! + 1, id: playerId)
          .whenSuccess((res) => apply(() {
                print('image updated');
                Navigator.of(EditPersonalPage.keyLoader.currentContext!, rootNavigator: true).pop();
                getContext((context) =>
                    App.navKey.currentState!.context.pushNamedAndRemoveUntil(BasePage.route, (_) => false));
              }));
      // updateProfileImage(
      //     id: player.id, version: player.version, imageId: await imageId);
      return res;
    });
  }

  @action
  // ignore: missing_return
  Future<int>? uploadVideo({
    File? file,
    int? videoVersion,
    int? videoId,
    bool? withDelete,
  }) {
    print('debug upload video1');
    imageId = _profileRepository.uploadFile(file: file).then((res1) async {
      final res = res1.getOrThrow();
      if (withDelete!) {
        await _profileRepository.uploadVideoPlayer(playerId: player!.id, videoId: res).whenSuccess((res) => apply(() {
              Navigator.of(VideosPage.keyLoader.currentContext!, rootNavigator: true).pop();
              fetchVideos(playerId: player!.id);
            }));
      } else {
        await _profileRepository
            .replaceVideoPlayer(playerId: player!.id, videoFileId: res, videoVersion: videoVersion, videoId: videoId)
            .whenSuccess((res) => apply(() {
                  Navigator.of(VideosPage.keyLoader.currentContext!, rootNavigator: true).pop();
                  fetchVideos(playerId: player!.id);
                }));
      }

      return res;
    });
  }

  @action
  void deleteVideo({int? videoVersion, int? videoId}) {
    deleteVideoFuture = futureWrapper(
      () => _profileRepository
          .deleteVideoPlayer(
            videoId: videoId,
            videoVersion: player!.id,
          )
          .whenSuccess(
            (res) => res?.apply(() {
              showSnack('Video deleted', scaffoldKey: VideosPage.scaffoldKey, duration: 2.seconds);
              fetchVideos(playerId: player!.id);
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void fetchVideos({int? playerId}) {
    fetchVideoFuture = futureWrapper(
      () => _profileRepository.fetchPlayerVideos(playerId: playerId).whenSuccess(
            (res) => res?.data ?? [],
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }
}
