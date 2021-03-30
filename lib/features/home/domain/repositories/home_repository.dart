import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/home/data/datasources/home_datasource.dart';

abstract class HomeRepository extends BaseRepository {
  const HomeRepository(HomeDataSource homeDataSource) : super(homeDataSource);
}
