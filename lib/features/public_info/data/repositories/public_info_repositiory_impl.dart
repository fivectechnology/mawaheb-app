import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/download_center_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/gallery_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/strategic_partners_model.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';

@LazySingleton(as: PublicInfoRepository)
class PublicInfoRepositoryImpl extends PublicInfoRepository {
  const PublicInfoRepositoryImpl(
      this.publicinfoDataSource, this._prefsRepository)
      : super(publicinfoDataSource);
  final PublicInfoDataSource publicinfoDataSource;
  final PrefsRepository? _prefsRepository;

  @override
  Future<NetworkResult<ListBaseResponseModel<AboutUsModel>?>> getAboutUs() =>
      publicinfoDataSource.getAboutUs();

  @override
  Future<NetworkResult<ListBaseResponseModel<ContactUsModel>?>> getContactUs() =>
      publicinfoDataSource.getContactUs();

  @override
  Future<NetworkResult<ListBaseResponseModel<StrategicPartnersModel>?>>
      getStrategicPartners() => publicinfoDataSource.getStrategicPartners();

  @override
  Future<NetworkResult<ListBaseResponseModel<DownloadCenterModel>?>>
      getDownloadCenter() => publicinfoDataSource.getDownloadCenter();

  @override
  Future<NetworkResult<ListBaseResponseModel<GalleryModel>?>> getGallery() =>
      publicinfoDataSource.getGallery();
}
