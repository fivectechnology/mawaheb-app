import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/notifications/data/datasources/notifications_datasource.dart';

import '../../../global_di.dart';

void main() {
  group('notification  dataSource => ', () {
    NotificationsDataSource notificationsDataSource;
    PrefsRepository prefsRepository;
    AuthDataSource authDataSource;
    setUp(() async {
      prefsRepository = FakePrefsRepository();
      final client = createDio(prefsRepositoryArgs: prefsRepository);
      authDataSource = AuthDataSourceImpl(
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
        client: client,
      );
      notificationsDataSource = NotificationsDataSourceImpl(
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
        client: client,
      );
      await authDataSource.login(userName: playerEmail, password: playerPassword, type: playerType);
    });

    tearDown(() {
      notificationsDataSource = null;
      authDataSource = null;
      prefsRepository = null;
    });

    test('success notification fetch', () async {
      final res = await notificationsDataSource.getNotifications(offset: 0, limit: 20);
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      expect(res.getOrThrow().data.first.subject, isNotNull);
      expect(res.getOrThrow().data.first.message, isNotNull);
    });
  });
}
