import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/constants.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/nav_stack.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/app_repository.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';
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
    SettingsRepository _settingsRepository,
  ) : super(logger, prefsRepository, appRepository, _settingsRepository);
}

abstract class _AppViewmodelBase extends BaseViewmodel with Store {
  _AppViewmodelBase(
    Logger logger,
    this.prefsRepository,
    this._appRepository,
    this._settingsRepository,
  ) : super(logger) {
    init();
  }

  final PrefsRepository prefsRepository;
  final AppRepository _appRepository;
  final SettingsRepository _settingsRepository;

  NavStack<AppBarParams?> appBarHistory = NavStack<AppBarParams?>();

  String? get userRole => prefsRepository.type /* ?? 'PLAYER' */;

  bool get isPlayer => userRole == 'PLAYER';

  //* OBSERVERS *//
  @observable
  AppBarParams? appBarParams;

  @observable
  PageIndex pageIndex = PageIndex.home;

  @observable
  ObservableFuture<String>? languageFuture;

  @observable
  bool languageLoading = false;

  @observable
  bool deviceRegistered = false;

  @observable
  int notificationsCount = 0;

  @observable
  bool? userRegested;

  //* COMPUTED *//

  @computed
  String get language => languageFuture?.value ?? defaultLanguage;

  //* ACTIONS *//
  //
  @action
  void init() {
    appBarParams = AppBarParams.initial(isPlayer);
    languageFuture = ObservableFuture.value(prefsRepository.languageCode);
    userRegested = !(prefsRepository.player == null);
    registerDevice();
  }

  @action
  void pushRoute(AppBarParams appBarParams) {
    appBarHistory.push(this.appBarParams);
    this.appBarParams = appBarParams;
  }

  @action
  void popRoute(BuildContext context, {VoidCallback? onBackPressed}) {
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
  void changeLanguage(String? locale, {updateBackend = false}) {
    logger.d('my debug update backend $updateBackend');
    if (locale == language) {
      return;
    }
    languageLoading = true;
    final tempFuture = ObservableFuture(
      (updateBackend
              ? _settingsRepository.updateLanguage(id: prefsRepository.player!.id, language: locale)
              : Future.value(Success(true)))
          .whenSuccess((res) => prefsRepository.setApplicationLanguage(locale))
          .then((res) => locale!),
    ).whenComplete(() => languageLoading = false);
    languageFuture = languageFuture?.replace(tempFuture) ?? tempFuture;
  }

  @action
  Future<void> registerDevice() async {
    deviceRegistered = await _appRepository.registerDevice();
  }

  @action
  void updateNotificationsCount({bool reset = false}) {
    _appRepository.getNotificationsCount(reset: reset).then((count) {
      notificationsCount = count;
    }).catchError((error) {
      logger.e('updateCartItemsCount => ERROR: $error');
    });
  }

  @action
  void toggleUserState({bool? status}) {
    if (status != null) {
      userRegested = status;
      return;
    }

    userRegested = !userRegested!;
  }

  @action
  void refreshUserStatus() {
    userRegested = prefsRepository.player != null;
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

String getBottomTitle(PageIndex pageIndex, bool isPlayer) {
  switch (pageIndex) {
    case PageIndex.home:
      return isPlayer ? 'lbl_profile' : 'lbl_players';

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
