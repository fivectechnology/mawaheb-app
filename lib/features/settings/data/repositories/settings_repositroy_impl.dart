import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/settings/data/datasources/settings_datasource.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  const SettingsRepositoryImpl(this.settingsDataSource) : super(settingsDataSource);
  final SettingsDataSource settingsDataSource;
}
