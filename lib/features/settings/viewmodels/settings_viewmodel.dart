import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

part 'settings_viewmodel.g.dart';

@injectable
class SettingsViewmodel extends _SettingsViewmodelBase with _$SettingsViewmodel {
  SettingsViewmodel(
    Logger logger,
    SettingsRepository settingsRepository,
    AuthRepository authRepository,
  ) : super(logger, settingsRepository, authRepository);
}

abstract class _SettingsViewmodelBase extends BaseViewmodel with Store {
  _SettingsViewmodelBase(
    Logger logger,
    this._settingsRepository,
    this._authRepository,
  ) : super(logger);
  final SettingsRepository _settingsRepository;
  final AuthRepository _authRepository;

  //* OBSERVERS *//
  @observable
  ObservableFuture<bool> logoutFuture;

  //* COMPUTED *//
  @computed
  bool get logoutLoading => logoutFuture?.isPending ?? false;

  //* ACTIONS *//
  @action
  void logout() {
    logoutFuture = futureWrapper(
      () => _authRepository.logout().whenSuccess(
            (res) => res.apply(
              () => getContext((context) => context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false)),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
