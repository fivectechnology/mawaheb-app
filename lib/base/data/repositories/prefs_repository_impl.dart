import 'dart:convert';

import 'package:core_sdk/utils/constants.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PrefsRepository)
class PrefsRepositoryImpl implements PrefsRepository {
  const PrefsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  String get token =>
      _prefs.getString(PreferencesKeys.USER_TOKEN) ?? base64Encode(utf8.encode('$DEFAULT_USER_NAME:$DEFAULT_PASSWORD'));

  //base64Encode(utf8.encode('${user.userName}:${user.password}'));

  // @override
  // Future<bool> setToken(String token) =>
  //     _prefs.setString(PreferencesKeys.USER_TOKEN, base64Encode(utf8.encode('${user.userName}:${user.password}')));

  @override
  Future<bool> setToken(String? token) {
    if (token == null) {
      return _prefs.remove(PreferencesKeys.USER_TOKEN);
    } else {
      return _prefs.setString(PreferencesKeys.USER_TOKEN, token);
    }
  }

  @override
  String? get type => _prefs.getString(PreferencesKeys.USER_GENDER);

  //base64Encode(utf8.encode('${user.userName}:${user.password}'));

  // @override
  // Future<bool> setToken(String token) =>
  //     _prefs.setString(PreferencesKeys.USER_TOKEN, base64Encode(utf8.encode('${user.userName}:${user.password}')));

  @override
  Future<bool> setType(String userType) async {
    await _prefs.setString(PreferencesKeys.USER_GENDER, userType);

    return true;
  }

  @override
  int? get fbId => _prefs.getInt(PreferencesKeys.FB_USER_TOKEN);

  @override
  Future<bool> setFbId(int? fbId) => _prefs.setInt(PreferencesKeys.FB_USER_TOKEN, fbId!);

  @override
  String get languageCode => _prefs.getString(PreferencesKeys.APP_LANGUAGE) ?? LANGUAGE_DEFAULT;

  @override
  Future<bool> setApplicationLanguage(String? languageCode) =>
      _prefs.setString(PreferencesKeys.APP_LANGUAGE, languageCode!);

  @override
  String? get baseUrl => _prefs.getString(PreferencesKeys.API_BASE_URL);

  @override
  Future<bool> setBaseUrl(String baseUrl) => _prefs.setString(PreferencesKeys.API_BASE_URL, baseUrl);

  @override
  Future<bool> setUser(UserModel user) => _prefs.setString(PreferencesKeys.USER_PROFILE, json.encode(user.toJson()));

  @override
  UserModel? get user {
    final jsonUser = _prefs.getString(PreferencesKeys.USER_PROFILE);
    return jsonUser != null ? UserModel.fromJson(json.decode(jsonUser)) : null;
  }

  // @override
  // bool get deviceRegistered => _prefs.getBool(PreferencesKeys.IS_DEVICE_REGISTERED) ?? false;

  // @override
  // Future<bool> setDeviceRegistered(bool status) => _prefs.setBool(PreferencesKeys.IS_DEVICE_REGISTERED, status);

  @override
  Future<bool> clearUserData() async {
    await _prefs.remove(PreferencesKeys.USER_PROFILE);
    await _prefs.remove(PreferencesKeys.USER_TOKEN);
    await _prefs.remove(PreferencesKeys.FB_USER_TOKEN);
    await _prefs.remove(PreferencesKeys.APP_LANGUAGE);
    await _prefs.remove(PreferencesKeys.CUSTOMER_PROFILE);
    await _prefs.remove(PreferencesKeys.USER_GENDER);
    // await _prefs.remove(PreferencesKeys.IS_DEVICE_REGISTERED);

    return true;
  }

  @override
  PlayerModel? get player {
    final jsonPlayer = _prefs.getString(PreferencesKeys.CUSTOMER_PROFILE);
    return jsonPlayer != null ? PlayerModel.fromJson(json.decode(jsonPlayer)) : null;
  }

  @override
  Future<bool> setPlayer(PlayerModel player) async =>
      _prefs.setString(PreferencesKeys.CUSTOMER_PROFILE, json.encode(player.toJson()));
}

const String DEFAULT_USER_NAME = 'apiuser@mawaheb.com';
const String DEFAULT_PASSWORD = 'welcome1';

// const String DEFAULT_USER_NAME = 'admin';
// const String DEFAULT_PASSWORD = 'admin';

