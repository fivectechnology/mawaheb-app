import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';

import '../global_di.dart';

void main() {
  group('auth dataSource =>', () {
    AuthDataSource authDataSource;
    PrefsRepository prefsRepository;

    setUp(() {
      prefsRepository = FakePrefsRepository(token: 'YWRtaW46YWRtaW4=');
      authDataSource = AuthDataSourceImpl(
        client: createDio(prefsRepositoryArgs: prefsRepository),
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
      );
    });

    tearDown(() {
      authDataSource = null;
    });

    test('success login function', () async {
      final NetworkResult<bool> res = await authDataSource.login(userName: 'admin', password: 'admin');
      expect(res.isSuccess, equals(true));
    });

    test('success signup function', () async {
      final res = await authDataSource.signUp(
        userName: 'admin as',
        password: 'admin asddasd',
        code: 'asdsad',
        email: 'asdfasdf@asdfafs.com',
      );
      expect(res.isSuccess, equals(true));
    });
  });

  group('auth repository =>', () {
    AuthDataSource authDataSource;
    AuthRepository authRepository;
    final prefs = FakePrefsRepository();

    setUp(() {
      authDataSource = AuthDataSourceImpl(
        client: createDio(prefsRepositoryArgs: prefs),
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefs,
      );

      authRepository = AuthRepositoryImpl(authDataSource, prefs);
    });

    tearDown(() {
      authDataSource = null;
      authRepository = null;
    });

    test('success login function', () async {
      final NetworkResult<bool> res = await authRepository.login(userName: 'admin', password: 'admin');
      expect(res.isSuccess, equals(true));
      expect(prefs.token, isNotNull);
      expect(prefs.user, equals(const UserModel(userName: 'admin', password: 'admin')));
    });
  });
}
