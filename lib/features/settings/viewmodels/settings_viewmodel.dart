import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:mobx/mobx.dart';

part 'settings_viewmodel.g.dart';

@injectable
class SettingsViewmodel extends _SettingsViewmodelBase with _$SettingsViewmodel {
  SettingsViewmodel(
    Logger logger,
    SettingsRepository settingsRepository,
  ) : super(logger, settingsRepository);
}

abstract class _SettingsViewmodelBase extends BaseViewmodel with Store {
  _SettingsViewmodelBase(Logger logger, this._settingsRepository) : super(logger);
  final SettingsRepository _settingsRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
