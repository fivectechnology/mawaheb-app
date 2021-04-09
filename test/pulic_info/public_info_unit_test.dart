import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';

import '../global_di.dart';

void main() {
  group('public info dataSource => ', () {
    PublicInfoDataSource publicInfoDataSource;
    PrefsRepository prefsRepository;
    setUp(() {
      prefsRepository = FakePrefsRepository(token: 'YWRtaW46YWRtaW4=');
      publicInfoDataSource = PublicInfoDataSourceImpl(
        connectionChecker: connectionChecker,
        client: createDio(prefsRepositoryArgs: prefsRepository),
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
      );
    });
    tearDown(() {
      publicInfoDataSource = null;
      prefsRepository = null;
    });

    test('test success about us', () async {
      final res = await publicInfoDataSource.getAboutUs();
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      expect(res.getOrThrow().data.first.mission, isNotNull);
      // expect(res.getOrThrow().data.first.ourValues, isNotNull);
    });
  });
}
