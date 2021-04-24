import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

abstract class PrefsRepository {
  const PrefsRepository();

  String get token;
  Future<bool> setToken(String token);

  String get type;
  Future<bool> setType(String type);

  int get fbId;
  Future<bool> setFbId(int fbId);

  String get baseUrl;
  Future<bool> setBaseUrl(String baseUrl);

  String get languageCode;
  Future<bool> setApplicationLanguage(String languageCode);

  UserModel get user;
  Future<bool> setUser(UserModel user);

  Future<bool> clearUserData();

  PlayerModel get player;
  Future<bool> setPlayer(PlayerModel player);

  // bool get deviceRegistered;
  // Future<bool> setDeviceRegistered(bool status);
}
