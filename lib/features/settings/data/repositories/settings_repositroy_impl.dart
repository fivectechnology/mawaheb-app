import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/settings/data/datasources/settings_datasource.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  const SettingsRepositoryImpl(this.settingsDataSource)
      : super(settingsDataSource);
  final SettingsDataSource settingsDataSource;

  @override
  Future<NetworkResult<bool>> sendOTP({String email, String password}) =>
      settingsDataSource.sendOTP(email: email, password: password);

  @override
  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP(
          {String email, int code}) =>
      settingsDataSource.verifyOTP(email: email, code: code);

  @override
  Future<NetworkResult<bool>> changeEmail({String email, int code}) =>
      settingsDataSource.changeEmail(email: email, code: code);

  @override
  Future<NetworkResult<bool>> changePassword(
          {String currentPassword, String newPassword, int id}) =>
      settingsDataSource.changePassword(
          currentPassword: currentPassword, newPassword: newPassword, id: id);
}
