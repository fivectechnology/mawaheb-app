import 'package:mawaheb_app/base/data/models/user_model.dart';

abstract class PrefsRepository {
  const PrefsRepository();

  String get fbToken;
  Future<bool> setFbToken(String fbToken);

  String get baseUrl;
  Future<bool> setBaseUrl(String baseUrl);

  String get languageCode;
  Future<bool> setApplicationLanguage(String languageCode);

  UserModel get user;
  Future<bool> setUser(UserModel user);

  Future<bool> clearUserData();
}
