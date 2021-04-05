import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

import '../../auth/auth_page.dart';

part 'splash_viewmodel.g.dart';

@injectable
class SplashViewmodel extends _SplashViewmodelBase with _$SplashViewmodel {
  SplashViewmodel(Logger logger, PrefsRepository prefsRepository)
      : super(logger, prefsRepository);
}

abstract class _SplashViewmodelBase extends BaseViewmodel with Store {
  _SplashViewmodelBase(Logger logger, this.prefsRepository) : super(logger) {
    Future.delayed(2.seconds).then((_) {
      // TODO(ahmad): use this when you want to test base pages without login
      getContext((context) =>
          context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false));
      // getContext((context) => context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false));

      // TODO(ahmad): use this when you want to test base pages without login
      // TODO(abd): find best way to know if the user logged in "ignore it for now"
      // getContext((context) {
      //   (prefsRepository.user) != null
      //       ? context.pushNamedAndRemoveUntil(BasePage.route, (_) => false)
      //       : context.pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
      // });
    });
  }

  final PrefsRepository prefsRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
