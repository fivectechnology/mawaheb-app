import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl(this.authDataSource, this._prefsRepository) : super(authDataSource);

  final AuthDataSource authDataSource;
  final PrefsRepository _prefsRepository;

  @override
  Future<NetworkResult<bool>> login({@required String userName, @required String password}) => authDataSource
      .login(userName: userName, password: password)
      .whenSuccessWrapped((_) => _prefsRepository.setUser(UserModel(userName: userName, password: password)));

  @override
  Future<NetworkResult<bool>> logout() =>
      authDataSource.logout().whenSuccessWrapped((_) => _prefsRepository.clearUserData());
}
