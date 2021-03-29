import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mobx/mobx.dart';

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

  //* COMPUTED *//

  //* ACTIONS *//

}
