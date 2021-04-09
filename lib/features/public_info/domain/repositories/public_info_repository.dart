import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';

abstract class PublicInfoRepository extends BaseRepository {
  const PublicInfoRepository(PublicInfoDataSource publicinfoDataSource) : super(publicinfoDataSource);

  Future<NetworkResult<ListBaseResponseModel<AboutUsModel>>> getAboutUs();
  Future<NetworkResult<BaseResponseModel<ContactUsModel>>> getContactUs();
}
