import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';

import '../global_di.dart';

void main() {
  group('public info dataSource => ', () {
    ProfileDataSource profileDataSource;
    PrefsRepository prefsRepository;
    setUp(() {
      prefsRepository = FakePrefsRepository(token: 'YWRtaW46YWRtaW4=');
      profileDataSource = ProfileDataSourceImpl(
        connectionChecker: connectionChecker,
        client: createDio(prefsRepositoryArgs: prefsRepository),
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
      );
    });
    tearDown(() {
      profileDataSource = null;
      prefsRepository = null;
    });

    test('test success about us', () async {
      final res = await profileDataSource.fetchProfile(id: 15);
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      // expect(res.getOrThrow().data.first.name, isNotNull);
      // expect(res.getOrThrow().data.first.code, isNotNull);
      // expect(res.getOrThrow().data.first., isNotNull);
      // expect(res.getOrThrow().data.first.ourValues, isNotNull);
    });
  });

  group('public info repository =>', () {
    ProfileDataSource profileDataSource;
    ProfileRepository profileRepository;
    PrefsRepository prefsRepository;

    setUp(() {
      prefsRepository = FakePrefsRepository(token: 'YWRtaW46YWRtaW4=');
      profileDataSource = ProfileDataSourceImpl(
        client: createDio(prefsRepositoryArgs: prefsRepository),
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
      );

      profileRepository =
          ProfileRepositoryImpl(profileDataSource, prefsRepository);
    });

    tearDown(() {
      profileRepository = null;
      profileDataSource = null;
      prefsRepository = null;
    });
  });
}
