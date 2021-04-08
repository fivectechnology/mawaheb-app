import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/public_info/data/datasources/public_info_datasource.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/repositories/public_info_repositiory_impl.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';

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
      expect(res.getOrThrow().data.first.vision, isNotNull);
      expect(res.getOrThrow().data.first.summary, isNotNull);
      expect(res.getOrThrow().data.first.ourValues, isNotNull);
    });

    test('test success contacts', () async {
      final res = await publicInfoDataSource.getContactUs();
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      expect(res.getOrThrow().data.first.address, isNotNull);
      expect(res.getOrThrow().data.first.country, isNotNull);
      expect(res.getOrThrow().data.first.email, isNotNull);
      expect(res.getOrThrow().data.first.emirate, isNotNull);
      expect(res.getOrThrow().data.first.googleMapsCoordination, isNotNull);
      expect(res.getOrThrow().data.first.phone, isNotNull);
    });

    test('test success strategic partners', () async {
      final res = await publicInfoDataSource.getStrategicPartners();
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      expect(res.getOrThrow().data.first.title, isNotNull);
      expect(res.getOrThrow().data.first.source.fileName, isNotNull);
    });
  });

  group('public info repository =>', () {
    PublicInfoDataSource publicInfoDataSource;
    PublicInfoRepository publicInfoRepository;

    setUp(() {
      publicInfoDataSource = PublicInfoDataSourceImpl(
        client: client,
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: FakePrefsRepository(),
      );

      publicInfoRepository =
          PublicInfoRepositoryImpl(publicInfoDataSource, prefsRepository);
    });

    tearDown(() {
      publicInfoDataSource = null;
      publicInfoRepository = null;
    });

    test('success about us function', () async {
      final res = await publicInfoRepository.getAboutUs();
      expect(res.isSuccess, equals(true));
    });
  });
}
