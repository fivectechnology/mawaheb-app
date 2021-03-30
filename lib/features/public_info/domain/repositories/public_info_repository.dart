import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';

abstract class PublicInfoRepository extends BaseRepository {
  const PublicInfoRepository(PublicInfoDataSource publicinfoDataSource) : super(publicinfoDataSource);
}
