import 'package:core_sdk/utils/nav_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'app_viewmodel.g.dart';

enum PageIndex {
  home, //? page name is 'profile' when role is [Player] or 'players' if role is [Club], for now name it home
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

  //* OBSERVERS *//
  @observable
  AppBarParams appBarParams = AppBarParams.initial();

  @observable
  PageIndex pageIndex = PageIndex.home;

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

  String get _appBarTitle {
    switch (pageIndex) {
      case PageIndex.home:
        return 'lbl_home';
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
