import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';

abstract class MawahebRepository extends BaseRepository {
  const MawahebRepository(MawahebRemoteDataSource mawahebDataSource) : super(mawahebDataSource);
}
