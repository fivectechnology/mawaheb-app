import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';

@LazySingleton(as: PublicInfoRepository)
class PublicInfoRepositoryImpl extends PublicInfoRepository {
  const PublicInfoRepositoryImpl(this.publicinfoDataSource) : super(publicinfoDataSource);
  final PublicInfoDataSource publicinfoDataSource;

  @override
  Future<NetworkResult<BaseResponseModel<AboutUsModel>>> getAboutUs() => publicinfoDataSource.getAboutUs();

  @override
  Future<NetworkResult<BaseResponseModel<ContactUsModel>>> getContactUs() => publicinfoDataSource.getContactUs();
}
