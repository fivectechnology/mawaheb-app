import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/home/domain/repositories/home_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

@injectable
class HomeViewmodel extends _HomeViewmodelBase with _$HomeViewmodel {
  HomeViewmodel(
    Logger logger,
    HomeRepository homeRepository,
  ) : super(logger, homeRepository);
}

abstract class _HomeViewmodelBase extends BaseViewmodel with Store {
  _HomeViewmodelBase(Logger logger, this._homeRepository) : super(logger);
  final HomeRepository _homeRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
