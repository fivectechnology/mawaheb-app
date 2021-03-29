import 'dart:convert';

import 'package:core_sdk/utils/constants.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: PrefsRepository)
class PrefsRepositoryImpl implements PrefsRepository {
  const PrefsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  String get fbToken => _prefs.getString(PreferencesKeys.FB_USER_TOKEN);

  @override
  Future<bool> setFbToken(String fbToken) => _prefs.setString(PreferencesKeys.FB_USER_TOKEN, fbToken);

  @override
  String get languageCode => _prefs.getString(PreferencesKeys.APP_LANGUAGE);

  @override
  Future<bool> setApplicationLanguage(String languageCode) =>
      _prefs.setString(PreferencesKeys.APP_LANGUAGE, languageCode);

  @override
  String get baseUrl => _prefs.getString(PreferencesKeys.API_BASE_URL);

  @override
  Future<bool> setBaseUrl(String baseUrl) => _prefs.setString(PreferencesKeys.API_BASE_URL, baseUrl);

  @override
  Future<bool> setUser(UserModel user) => _prefs.setString(PreferencesKeys.USER_PROFILE, json.encode(user.toJson()));

  @override
  UserModel get user {
    final jsonUser = _prefs.getString(PreferencesKeys.USER_PROFILE);
    return jsonUser != null ? UserModel.fromJson(json.decode(jsonUser)) : null;
  }

  @override
  Future<void> clearUserData() async {
    await _prefs.remove(PreferencesKeys.USER_PROFILE);
    await _prefs.remove(PreferencesKeys.FB_USER_TOKEN);
    await _prefs.remove(PreferencesKeys.APP_LANGUAGE);
  }
}
