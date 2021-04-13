import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/players/ui/pages/player_info_page.dart';
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

  @observable
  ObservableFuture<PlayerModel> registerFuture;

  //* COMPUTED *//
  @computed
  bool get loginLoading => loginFuture?.isPending ?? false;

  @computed
  bool get loginError => loginFuture?.isFailure ?? false;

  @computed
  PlayerModel get data => registerFuture?.value;

  @computed
  bool get registerLoading => registerFuture?.isPending ?? false;

  //* ACTIONS *//

  @action
  void login({String userName, String password}) {
    loginFuture = futureWrapper(
      () => _authRepository
          .login(userName: userName, password: password)
          .whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushNamedAndRemoveUntil(
                    BasePage.route, (_) => false),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void signUp({String username, String email, String password}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .signUp(userName: username, email: email, password: password)
          .whenSuccess(
            (res) => res.data.first,

            //   res.apply(
            // () => getContext((context) => context.pushPage(PlayerInfoPage())),
          )
          .whenComplete(
            () => getContext((context) => context.pushPage(PlayerInfoPage())),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
