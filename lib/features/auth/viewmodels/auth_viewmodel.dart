import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

part 'auth_viewmodel.g.dart';

@injectable
class AuthViewmodel extends _AuthViewmodelBase with _$AuthViewmodel {
  AuthViewmodel(
    Logger logger,
    AuthRepository authRepository,
  ) : super(logger, authRepository);
}

abstract class _AuthViewmodelBase extends BaseViewmodel with Store {
  _AuthViewmodelBase(Logger logger, this._authRepository) : super(logger);

  final AuthRepository _authRepository;

  //* OBSERVERS *//

  @observable
  ObservableFuture<bool> loginFuture;

  //* COMPUTED *//
  @computed
  bool get loginLoading => loginFuture?.isPending ?? false;

  @computed
  bool get loginError => loginFuture?.isFailure ?? false;

  //* ACTIONS *//

  @action
  void login({String userName, String password}) {
    loginFuture = futureWrapper(
      () => _authRepository.login(userName: userName, password: password).whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushNamedAndRemoveUntil(BasePage.route, (_) => false),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
