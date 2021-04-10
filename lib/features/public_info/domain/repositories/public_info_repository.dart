import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/download_center_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/gallery_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/strategic_partners_model.dart';

abstract class PublicInfoRepository extends BaseRepository {
  const PublicInfoRepository(PublicInfoDataSource publicinfoDataSource)
      : super(publicinfoDataSource);

  Future<NetworkResult<ListBaseResponseModel<AboutUsModel>>> getAboutUs();
  Future<NetworkResult<ListBaseResponseModel<ContactUsModel>>> getContactUs();
  Future<NetworkResult<ListBaseResponseModel<StrategicPartnersModel>>>
      getStrategicPartners();

  Future<NetworkResult<ListBaseResponseModel<GalleryModel>>> getGallery();

  Future<NetworkResult<ListBaseResponseModel<DownloadCenterModel>>>
      getDownloadCenter();
}
