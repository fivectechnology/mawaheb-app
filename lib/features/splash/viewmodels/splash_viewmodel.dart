import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:mobx/mobx.dart';

import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import '../../auth/auth_page.dart';

part 'splash_viewmodel.g.dart';

@injectable
class SplashViewmodel extends _SplashViewmodelBase with _$SplashViewmodel {
  SplashViewmodel(Logger logger, PrefsRepository prefsRepository,
      AuthRepository authRepository)
      : super(logger, prefsRepository, authRepository);
}

abstract class _SplashViewmodelBase extends BaseViewmodel with Store {
  _SplashViewmodelBase(Logger logger, this.prefsRepository, this.authRepository)
      : super(logger) {
    Future.delayed(2.seconds).then((_) {
      // TODO(ahmad): use this when you want to test base pages without login
      // getContext((context) => context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false));
      // print(prefsRepository.type);
      if (prefsRepository.player != null &&
          prefsRepository.player.status == 'INACTIVE') {
        logout();
      }
      // TODO(ahmad): use this in release
      getContext((context) {
        (prefsRepository.user) != null
            ? context.pushNamedAndRemoveUntil(BasePage.route, (_) => false)
            : context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
      });
    });
  }

  final PrefsRepository prefsRepository;
  final AuthRepository authRepository;

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
      () => logoutAsFuture(),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
      useLoader: true,
    );
  }

  Future<bool> logoutAsFuture() {
    return authRepository.logout().then(
          (res) => res.apply(() {
            App.navKey.currentState
                .pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
            getContext(
              (context) => Provider.of<AppViewmodel>(context, listen: false)
                  .navigateTo(PageIndex.home),
            );
          }),
        );
  }
}
