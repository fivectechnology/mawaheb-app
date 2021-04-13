import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

abstract class AuthDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<bool>> login({@required String userName, @required String password});

  Future<NetworkResult<BaseResponseModel<String>>> logout();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required String userName,
    @required String code,
    @required String email,
    @required String password,
  });
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
  Future<NetworkResult<bool>> login({
    @required String userName,
    @required String password,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: LOGIN_ENDPOINT,
      withAuth: false,
      data: {'username': userName, 'password': password},
    );
  }

  // TODO(ahmad): need test
  @override
  Future<NetworkResult<BaseResponseModel<String>>> logout() {
    return mawahebRequest(
      method: METHOD.GET,
      endpoint: LOGIN_ENDPOINT,
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required String userName,
    @required String code,
    @required String email,
    @required String password,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      // endpoint: PROFILE_UPDATE_ENDPOINT,
      mawahebModel: false,
      modelName: 'auth.db.User',
      withAuth: true,
      data: {
        'data': {
          'code': code,
          'name': userName,
          'email': email,
          'password': password,
        }
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }
}
