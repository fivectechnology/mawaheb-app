import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/settings/data/datasources/settings_datasource.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  const SettingsRepositoryImpl(
    this.settingsDataSource,
    this._prefsRepository,
    this._authRepository,
  ) : super(settingsDataSource);
  final SettingsDataSource settingsDataSource;
  final PrefsRepository _prefsRepository;
  final AuthRepository _authRepository;

  @override
  Future<NetworkResult<String?>> sendOTP({String? email, String? password}) =>
      settingsDataSource.sendOTP(email: email, password: password);

  @override
  Future<NetworkResult<BaseResponseModel<OTPResponseModel>?>> verifyOTP({String? email, int? code}) =>
      settingsDataSource.verifyOTP(email: email, code: code);

  @override
  Future<NetworkResult<bool?>> changeEmail({String? email, int? code}) => settingsDataSource
      .changeEmail(email: email, code: code)
      .whenSuccessWrapped(
        (res) => _authRepository.login(
          userName: email ?? '',
          password: _prefsRepository.user?.password ?? '',
          type: _prefsRepository.type ?? '',
        ),
      )
      .whenSuccessWrapped((res) => true);

  @override
  Future<NetworkResult<bool?>> changePassword({String? currentPassword, String? newPassword, int? id}) =>
      settingsDataSource
          .changePassword(currentPassword: currentPassword, newPassword: newPassword, id: id)
          .whenSuccessWrapped(
            (res) => _authRepository.login(
              userName: _prefsRepository.user?.userName ?? '',
              password: newPassword ?? '',
              type: _prefsRepository.type ?? '',
            ),
          )
          .whenSuccessWrapped((res) => true);
  // .whenSuccessWrapped((res) =>
  //     _prefsRepository.setUser(UserModel(userName: _prefsRepository.user?.userName, password: newPassword)));

  @override
  Future<NetworkResult<bool?>> updateLanguage({int? id, String? language}) =>
      settingsDataSource.updateLanguage(id: id, language: language);
}
