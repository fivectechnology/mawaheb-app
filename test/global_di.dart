import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/utils/token_interceptor.dart';

import 'package:mockito/mockito.dart';

class FakePrefsRepository extends Mock implements PrefsRepository {
  // try new 5c repo
  FakePrefsRepository({String token}) {
    _token = token;
  }

  UserModel _userModel;
  String _token;

  @override
  Future<bool> clearUserData() async {
    _userModel = null;
    _token = null;
    return true;
  }

  @override
  Future<bool> setToken() async {
    _token = _token;
    return true;
  }

  @override
  Future<bool> setUser(UserModel user) async {
    _userModel = user;
    _token = 'fakeToke';
    return true;
  }

  @override
  String get token => _token;

  @override
  UserModel get user => _userModel;
}

PrefsRepository get prefsRepository => FakePrefsRepository();

DataConnectionChecker connectionChecker = DataConnectionChecker();

BaseOptions dioOption = BaseOptions(
  baseUrl: BASE_API,
  connectTimeout: 15000,
  receiveTimeout: 15000,
  contentType: 'application/json;charset=utf-8',
  responseType: ResponseType.plain,
  headers: <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Connection': 'keep-alive',
  },
);

Dio createDio({PrefsRepository prefsRepositoryArgs}) {
  final Dio dio = Dio(dioOption);
  return dio
    ..interceptors.addAll(<Interceptor>[
      TokenInterceptor(baseDio: dio, prefsRepository: prefsRepositoryArgs ?? prefsRepository),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        request: true,
        // logPrint: (Object err) => logger.w('LogInterceptor:$err'),
      ),
    ]);
}

Dio get client => createDio();
