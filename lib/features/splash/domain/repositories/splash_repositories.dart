import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/splash/data/datasources/splash_datasource.dart';

abstract class SplashRepository extends BaseRepository {
  const SplashRepository(SplashDataSource splashDataSource) : super(splashDataSource);
}
