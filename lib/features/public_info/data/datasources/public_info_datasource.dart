import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';

abstract class PublicInfoDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<BaseResponseModel<AboutUsModel>>> getAboutUs();
  Future<NetworkResult<BaseResponseModel<ContactUsModel>>> getContactUs();
}

@LazySingleton(as: PublicInfoDataSource)
class PublicInfoDataSourceImpl extends MawahebRemoteDataSource implements PublicInfoDataSource {
  PublicInfoDataSourceImpl({
    @required Dio client,
    @required PrefsRepository prefsRepository,
    @required DataConnectionChecker connectionChecker,
    @required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          connectionChecker: connectionChecker,
          logger: logger,
        );

  @override
  Future<NetworkResult<BaseResponseModel<AboutUsModel>>> getAboutUs() {
    return mawahebRequest(
      modelName: 'AboutUs',
      // endpoint: '/ws/rest/com.axelor.mawaheb.base.db.AboutUs/search',
      action: EndPointAction.search,
      method: METHOD.POST,
      mapper: BaseResponseModel.fromJson(AboutUsModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<ContactUsModel>>> getContactUs() {
    return mawahebRequest(
      modelName: 'ContactUs',
      action: EndPointAction.search,
      method: METHOD.POST,
      mapper: BaseResponseModel.fromJson(ContactUsModel.fromJson),
    );
  }
}
