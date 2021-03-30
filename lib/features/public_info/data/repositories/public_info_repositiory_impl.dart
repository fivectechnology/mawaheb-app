import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';

@LazySingleton(as: PublicInfoRepository)
class PublicInfoRepositoryImpl extends PublicInfoRepository {
  const PublicInfoRepositoryImpl(this.publicinfoDataSource) : super(publicinfoDataSource);
  final PublicInfoDataSource publicinfoDataSource;
}
