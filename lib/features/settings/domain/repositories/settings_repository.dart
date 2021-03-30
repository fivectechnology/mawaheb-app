import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/settings/data/datasources/settings_datasource.dart';

abstract class SettingsRepository extends BaseRepository {
  const SettingsRepository(SettingsDataSource settingsDataSource) : super(settingsDataSource);
}
