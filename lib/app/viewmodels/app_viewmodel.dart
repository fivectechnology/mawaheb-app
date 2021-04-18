import 'package:core_sdk/utils/nav_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/features/notifications/ui/pages/notifications_page.dart';
import 'package:mawaheb_app/features/players/ui/pages/players_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/profile_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/public_info_page.dart';
import 'package:mawaheb_app/features/settings/ui/settings_page.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'app_viewmodel.g.dart';

enum PageIndex {
  profile, //? page name is 'profile' when role is [Player] or 'players' if role is [Club], for now name it home
  player,
  notifications,
  public_info,
  settings,
}

// TODO(ahmad): you should add profile info here and handle subscribe logics
@injectable
class AppViewmodel extends _AppViewmodelBase with _$AppViewmodel {
  AppViewmodel(Logger logger) : super(logger);
}

abstract class _AppViewmodelBase extends BaseViewmodel with Store {
  _AppViewmodelBase(Logger logger) : super(logger);

  NavStack<AppBarParams> appBarHistory = NavStack<AppBarParams>();
  PrefsRepository prefsRepository;

  final List<Widget> pages = <Widget>[
    Navigator(
        key: ProfilePage.navKey,
        onGenerateRoute: (RouteSettings route) => ProfilePage.pageRoute),
    Navigator(
        key: NotificationsPage.navKey,
        onGenerateRoute: (RouteSettings route) => NotificationsPage.pageRoute),
    Navigator(
        key: PublicInfoPage.navKey,
        onGenerateRoute: (RouteSettings route) => PublicInfoPage.pageRoute),
    Navigator(
        key: SettingsPage.navKey,
        onGenerateRoute: (RouteSettings route) => SettingsPage.pageRoute),
  ];

  //* OBSERVERS *//
  @observable
  AppBarParams appBarParams = AppBarParams.initial();

  @observable
  PageIndex pageIndex;

  //* COMPUTED *//

  //* ACTIONS *//

  @action
  void pushRoute(AppBarParams appBarParams) {
    appBarHistory.push(this.appBarParams);
    this.appBarParams = appBarParams;
  }

  @action
  void popRoute(BuildContext context, {VoidCallback onBackPressed}) {
    appBarParams = appBarHistory.pop();
    onBackPressed == null ? context.pop() : onBackPressed();
  }

  @action
  void replaceAppBar(AppBarParams appBarParams) {
    this.appBarParams = appBarParams;
  }

  @action
  void navigateTo(PageIndex newPageIndex) {
    if (pageIndex != newPageIndex) {
      pageIndex = newPageIndex;
      appBarHistory.clear();
      pushRoute(AppBarParams(title: _appBarTitle, onBackPressed: null));
    }
  }

  @action
  void checkType() {
    if (prefsRepository.type != 'PLAYER') {
      pageIndex = PageIndex.player;
      pages[0] = Navigator(
          key: PlayersPage.navKey,
          onGenerateRoute: (RouteSettings route) => PlayersPage.pageRoute);
    } else {
      pageIndex = PageIndex.profile;
      pages[0] = Navigator(
          key: ProfilePage.navKey,
          onGenerateRoute: (RouteSettings route) => ProfilePage.pageRoute);
    }
  }

  String get _appBarTitle {
    switch (pageIndex) {
      case PageIndex.profile:
        return 'lbl_profile';
      case PageIndex.player:
        return 'lbl_available_players';
      case PageIndex.notifications:
        return 'lbl_notifications';
      case PageIndex.public_info:
        return 'lbl_public_info';
      case PageIndex.settings:
        return 'lbl_settigs';
      default:
        return 'not_exist';
    }
  }
}
