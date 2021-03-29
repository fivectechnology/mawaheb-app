import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

@injectable
class HomeViewmodel extends _HomeViewmodelBase with _$HomeViewmodel {
  HomeViewmodel(Logger logger) : super(logger);
}

abstract class _HomeViewmodelBase extends BaseViewmodel with Store {
  _HomeViewmodelBase(Logger logger) : super(logger);
  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
