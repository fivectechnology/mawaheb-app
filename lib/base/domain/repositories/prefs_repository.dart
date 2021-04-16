import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

abstract class PrefsRepository {
  const PrefsRepository();

  String get token;
  Future<bool> setToken();

  String get fbToken;
  Future<bool> setFbToken(String fbToken);

  String get baseUrl;
  Future<bool> setBaseUrl(String baseUrl);

  String get languageCode;
  Future<bool> setApplicationLanguage(String languageCode);

  UserModel get user;
  Future<bool> setUser(UserModel user);

  Future<bool> clearUserData();

  PlayerModel get player;
  Future<bool> setPlayer(PlayerModel player);
}
