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

abstract class AuthDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<BaseResponseModel<String>>> login({@required String userName, @required String password});
  Future<NetworkResult<BaseResponseModel<String>>> logout();
  Future<NetworkResult<BaseResponseModel<String>>> getAboutUs();
  Future<NetworkResult<BaseResponseModel<String>>> getContactUs();
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl extends MawahebRemoteDataSource implements AuthDataSource {
  AuthDataSourceImpl({
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
  Future<NetworkResult<BaseResponseModel<String>>> login({
    @required String userName,
    @required String password,
  }) {
    return request(
      method: METHOD.POST,
      endpoint: LOGIN_ENDPOINT,
      data: {'username': userName, 'password': password},
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<String>>> logout() {
    return request(
      method: METHOD.GET,
      endpoint: LOGIN_ENDPOINT,
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<String>>> getAboutUs() {
    return request(
      method: METHOD.POST,
      endpoint: ABOUT_US_ENDPOINT,
      data: {
        'data': {},
        'fields': ['summary', 'vision', 'mission', 'ourValues']
      },
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<String>>> getContactUs() {
    return request(
      method: METHOD.POST,
      endpoint: CONTACT_US_ENDPOINT,
      data: {
        'data': {},
        'fields': ['email', 'phone', 'country', 'emirate', 'address', 'googleMapsCoordination']
      },
    );
  }
}
