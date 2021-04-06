import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';

abstract class AuthRepository extends BaseRepository {
  const AuthRepository(AuthDataSource authDataSource) : super(authDataSource);

  Future<NetworkResult<bool>> login({@required String userName, @required String password});

  Future<NetworkResult<bool>> logout();
}
