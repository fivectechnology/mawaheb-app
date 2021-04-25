import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/constants.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/nav_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/app_repository.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mobx/mobx.dart';

part 'app_viewmodel.g.dart';

const String defaultLanguage = LANGUAGE_ARABIC;

enum PageIndex {
  home,
  notifications,
  public_info,
  settings,
}

// TODO(ahmad): you should add profile info here and handle subscribe logics
@injectable
class AppViewmodel extends _AppViewmodelBase with _$AppViewmodel {
  AppViewmodel(
    Logger logger,
    PrefsRepository prefsRepository,
    AppRepository appRepository,
  ) : super(logger, prefsRepository, appRepository);
}

abstract class _AppViewmodelBase extends BaseViewmodel with Store {
  _AppViewmodelBase(Logger logger, this.prefsRepository, this._appRepository) : super(logger) {
    init();
  }

  final PrefsRepository prefsRepository;
  final AppRepository _appRepository;

  NavStack<AppBarParams> appBarHistory = NavStack<AppBarParams>();

  String get userRole => prefsRepository?.type /* ?? 'PLAYER' */;

  bool get isPlayer => userRole == 'PLAYER';

  //* OBSERVERS *//
  @observable
  AppBarParams appBarParams;

  @observable
  PageIndex pageIndex = PageIndex.home;

  @observable
  ObservableFuture<String> languageFuture;

  @observable
  bool deviceRegistered = false;

  @observable
  int notificationsCount = 0;

  //* COMPUTED *//

  @computed
  String get language => languageFuture?.value ?? defaultLanguage;

  @computed
  bool get languageLoading => languageFuture?.isPending ?? false;

  //* ACTIONS *//
  //
  @action
  void init() {
    appBarParams = AppBarParams.initial(isPlayer);
    languageFuture = ObservableFuture.value(prefsRepository.languageCode);
    registerDevice();
  }

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
      pushRoute(AppBarParams(title: getAppBarTitle(pageIndex, isPlayer), onBackPressed: null));
    }
  }

  @action
  void changeLanguage(String locale) {
    if (locale == language) {
      return;
    }
    languageFuture = ObservableFuture(prefsRepository.setApplicationLanguage(locale).then((isSuccess) {
      logger.d('mawaheb debug try change language status is $isSuccess');
      return locale;
    }));
  }

  @action
  Future<void> registerDevice() async {
    deviceRegistered = await _appRepository.registerDevice();
  }

  @action
  void updateNotificationsCount() {
    _appRepository.getNotificationsCount().then((count) {
      notificationsCount = count;
    }).catchError((error) {
      logger.e('updateCartItemsCount => ERROR: $error');
    });
  }
}

String getAppBarTitle(PageIndex pageIndex, bool isPlayer) {
  switch (pageIndex) {
    case PageIndex.home:
      return isPlayer ? 'lbl_profile' : 'lbl_available_players';

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
