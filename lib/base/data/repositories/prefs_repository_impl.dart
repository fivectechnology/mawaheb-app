import 'dart:convert';

import 'package:core_sdk/utils/constants.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

const String DEFAULT_USER_NAME = 'admin';
const String DEFAULT_PASSWORD = 'admin';

@Singleton(as: PrefsRepository)
class PrefsRepositoryImpl implements PrefsRepository {
  const PrefsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  String get token =>
      _prefs.getString(PreferencesKeys.USER_TOKEN) ??
      base64Encode(utf8.encode('$DEFAULT_USER_NAME:$DEFAULT_PASSWORD'));
  //base64Encode(utf8.encode('${user.userName}:${user.password}'));

  @override
  Future<bool> setToken() => _prefs.setString(PreferencesKeys.USER_TOKEN,
      base64Encode(utf8.encode('${user.userName}:${user.password}')));

  @override
  String get fbToken => _prefs.getString(PreferencesKeys.FB_USER_TOKEN);

  @override
  Future<bool> setFbToken(String fbToken) =>
      _prefs.setString(PreferencesKeys.FB_USER_TOKEN, fbToken);

  @override
  String get languageCode =>
      _prefs?.getString(PreferencesKeys.APP_LANGUAGE) ?? LANGUAGE_DEFAULT;

  @override
  Future<bool> setApplicationLanguage(String languageCode) =>
      _prefs.setString(PreferencesKeys.APP_LANGUAGE, languageCode);

  @override
  String get baseUrl => _prefs.getString(PreferencesKeys.API_BASE_URL);

  @override
  Future<bool> setBaseUrl(String baseUrl) =>
      _prefs.setString(PreferencesKeys.API_BASE_URL, baseUrl);

  @override
  Future<bool> setUser(UserModel user) async {
    await _prefs.setString(
        PreferencesKeys.USER_PROFILE, json.encode(user.toJson()));
    return setToken();
  }

  @override
  UserModel get user {
    final jsonUser = _prefs.getString(PreferencesKeys.USER_PROFILE);
    return jsonUser != null ? UserModel.fromJson(json.decode(jsonUser)) : null;
  }

  @override
  Future<bool> clearUserData() async {
    await _prefs.remove(PreferencesKeys.USER_PROFILE);
    await _prefs.remove(PreferencesKeys.USER_TOKEN);
    await _prefs.remove(PreferencesKeys.FB_USER_TOKEN);
    await _prefs.remove(PreferencesKeys.APP_LANGUAGE);
    await _prefs.remove(PreferencesKeys.CUSTOMER_PROFILE);
    return true;
  }

  @override
  PlayerModel get player {
    final jsonPlayer = _prefs.getString(PreferencesKeys.CUSTOMER_PROFILE);
    return jsonPlayer != null
        ? PlayerModel.fromJson(json.decode(jsonPlayer))
        : null;
  }

  @override
  Future<bool> setPlayer(PlayerModel player) async => _prefs.setString(
      PreferencesKeys.CUSTOMER_PROFILE, json.encode(player.toJson()));
}
