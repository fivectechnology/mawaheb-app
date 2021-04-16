import 'package:core_sdk/utils/Fimber/logger_impl.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
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

    // test('success login function', () async {
    //   final NetworkResult<bool> res =
    //       await authDataSource.login(userName: 'admin', password: 'admin');
    //   expect(res.isSuccess, equals(true));
    // });

    // test('success login function', () async {
    //   final NetworkResult<bool> res = await authDataSource.sendOTP(
    //     email: 'ahmad.shihab2019@gmail.com',
    //   );
    //   expect(res.isSuccess, equals(true));
    // });

    // test('success signup function', () async {
    //   final res = await authDataSource.signUp(
    //     userName: 'admin as2',
    //     password: 'admin asddasd2',
    //     code: 'asdsad2',
    //     email: 'asdfasdf@asdfafs.com',
    //   );
    //   expect(res.isSuccess, equals(true));
    //   // expect(res.getOrThrow().data.first.name, isNotNull);
    //   // expect(res.getOrThrow().data.first.code, isNotNull);
    //   // expect(res.getOrThrow().data.first.email, isNotNull);
    // });

    // test('success personal info function', () async {
    //   final res = await authDataSource.addPersonalInfo(
    //       name: 'test',
    //       id: 15,
    //       dateOfBirth: '2020-01-01',
    //       gender: 'MALE',
    //       phone: '+9999999999');
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().data.first.gender, isNotNull);
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    //   expect(res.getOrThrow().data.first.dateOfBirth, isNotNull);
    //   expect(res.getOrThrow().data.first.phone, isNotNull);
    // });
    //
    // test('success personal info function', () async {
    //   final res = await authDataSource.addPersonalInfo(
    //       name: 'test',
    //       id: 15,
    //       dateOfBirth: '2020-01-01',
    //       gender: 'MALE',
    //       phone: '+9999999999');
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().data.first.gender, isNotNull);
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    //   expect(res.getOrThrow().data.first.dateOfBirth, isNotNull);
    //   expect(res.getOrThrow().data.first.phone, isNotNull);
    // });
    //
    // test('success address info function', () async {
    //   final res = await authDataSource.addAddressInfo(
    //       address: 'test', area: 'test', id: 15);
    //   expect(res.isSuccess, equals(true));
    //   // expect(res.getOrThrow().data.first.address, isNotNull);
    //   // expect(res.getOrThrow().data.first.area, isNotNull);
    // });
    //
    // test('success sport info function', () async {
    //   final res = await authDataSource.addSportInfo(
    //     id: 15,
    //     hand: 'RIGHT',
    //     leg: 'RIGHT',
    //     height: '160',
    //     weight: '60',
    //   );
    //   expect(res.isSuccess, equals(true));
    //   // expect(res.getOrThrow().data.first.hand, isNotNull);
    //   // expect(res.getOrThrow().data.first.leg, isNotNull);
    //   // expect(res.getOrThrow().data.first.height, isNotNull);
    //   // expect(res.getOrThrow().data.first.weight, isNotNull);
    // });

    // test('test success get spots functions', () async {
    //   final res = await authDataSource.getSports();
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    // });
    //
    // test('test success get categories functions', () async {
    //   final res = await authDataSource.getCategories();
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.title, isNotNull);
    // });
    //
    // test('test success get county functions', () async {
    //   final res = await authDataSource.getCountries();
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    // });
    //
    // test('test success get emirate functions', () async {
    //   final res = await authDataSource.getEmirates();
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    // });
    //
    // test('test success get position functions', () async {
    //   final res = await authDataSource.getPositions();
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    // });
  });

  group('auth repository =>', () {
    AuthDataSource authDataSource;
    AuthRepository authRepository;
    PrefsRepository prefsRepository;

    setUp(() {
      prefsRepository = FakePrefsRepository(token: 'YWRtaW46YWRtaW4=');

      authDataSource = AuthDataSourceImpl(
        client: createDio(prefsRepositoryArgs: prefsRepository),
        connectionChecker: connectionChecker,
        logger: LoggerImpl(),
        prefsRepository: prefsRepository,
      );

      authRepository = AuthRepositoryImpl(authDataSource, prefsRepository);
    });

    tearDown(() {
      authDataSource = null;
      authRepository = null;
      prefsRepository = null;
    });

    // test('success login function', () async {
    //   final NetworkResult<bool> res =
    //       await authRepository.login(userName: 'admin', password: 'admin');
    //   expect(res.isSuccess, equals(true));
    //   expect(prefsRepository.token, isNotNull);
    //   expect(prefsRepository.user,
    //       equals(const UserModel(userName: 'admin', password: 'admin')));
    // });

    // test('test signup function', () async {
    //   final res = await authRepository.signUp(
    //     userName: 'admin as444',
    //     password: 'admin asddasd444',
    //     code: 'asdsad444',
    //     email: 'asdfasdf444@asdfafs.com',
    //   );
    //   expect(res.isSuccess, equals(true));
    //   expect(res.getOrThrow().status, equals(0));
    //   expect(res.getOrThrow().data.first.name, isNotNull);
    //   expect(res.getOrThrow().data.first.email, isNotNull);
    // });

    test('test signup function', () async {
      final res = await authRepository.addPersonalInfo(
        id: 38,
        version: 1,
        phone: '+99999998888',
        gender: 'MALE',
        name: 'testtt',
        dateOfBirth: '2020-02-02',
        country: const CountryModel(name: 'UAE', id: 1, version: 0),
        categoryModel: const CategoryModel(title: 'test', id: 1, version: 0),
      );
      expect(res.isSuccess, equals(true));
      expect(res.getOrThrow().status, equals(0));
      expect(res.getOrThrow().data.first.name, isNotNull);
      expect(res.getOrThrow().data.first.email, isNotNull);
    });
  });
}
