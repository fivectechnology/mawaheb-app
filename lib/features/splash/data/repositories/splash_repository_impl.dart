import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/splash/data/datasources/splash_datasource.dart';
import 'package:mawaheb_app/features/splash/domain/repositories/splash_repositories.dart';

@LazySingleton(as: SplashRepository)
class SplashRepositoryImpl extends SplashRepository {
  const SplashRepositoryImpl(this.splashDataSource) : super(splashDataSource);
  final SplashDataSource splashDataSource;
}
