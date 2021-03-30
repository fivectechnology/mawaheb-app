import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/home/data/datasources/home_datasource.dart';
import 'package:mawaheb_app/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  const HomeRepositoryImpl(this.homeDataSource) : super(homeDataSource);
  final HomeDataSource homeDataSource;

  // TODO(ahmad): add abstract function here and implement them in Impl section
}
