import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/ui/pages/videos_page.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mawaheb_app/features/profile/ui/pages/my_info_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/view_page.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'profile_viewmodel.g.dart';

@injectable
class ProfileViewmodel extends _ProfileViewmodelBase with _$ProfileViewmodel {
  ProfileViewmodel(
    Logger logger,
    ProfileRepository profileRepository,
  ) : super(logger, profileRepository);
}

abstract class _ProfileViewmodelBase extends BaseViewmodel with Store {
  _ProfileViewmodelBase(Logger logger, this._profileRepository) : super(logger);
  final ProfileRepository _profileRepository;

  List<Widget> pages = const [
    MyInfoPage(),
    VideosPage(),
    ViewsPage(),
  ];

  //* OBSERVERS *//
  @observable
  ObservableFuture<PlayerModel> playerFuture;

  //* COMPUTED *//
  @computed
  PlayerModel get player => playerFuture?.value;

  @computed
  bool get playerLoading => playerFuture?.isPending ?? false;

  //* ACTIONS *//
  @action
  void fetchPlayer() => playerFuture = futureWrapper(
        () => _profileRepository
            .fetchPlayer()
            .whenSuccess((res) => res.data.first),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );
}
