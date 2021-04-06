import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';

import '../global_di.dart';

void main() {
  group('auth dataSource =>', () {
    AuthDataSource authDataSource;

    setUp(() {
      authDataSource = AuthDataSourceImpl(
        client: client,
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: FakePrefsRepository(),
      );
    });

    tearDown(() {
      authDataSource = null;
    });

    test('success login function', () async {
      final NetworkResult<bool> res = await authDataSource.login(userName: 'admin', password: 'admin');
      expect(res.isSuccess, equals(true));
    });
  });

  group('auth repository =>', () {
    AuthDataSource authDataSource;
    AuthRepository authRepository;

    setUp(() {
      authDataSource = AuthDataSourceImpl(
        client: client,
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: FakePrefsRepository(),
      );

      authRepository = AuthRepositoryImpl(authDataSource, prefsRepository);
    });

    tearDown(() {
      authDataSource = null;
      authRepository = null;
    });

    test('success login function', () async {
      final NetworkResult<bool> res = await authRepository.login(userName: 'admin', password: 'admin');
      expect(res.isSuccess, equals(true));
      expect(prefsRepository.token, isNotNull);
      expect(prefsRepository.user, equals(const UserModel(userName: 'admin', password: 'admin')));
    });
  });
}
