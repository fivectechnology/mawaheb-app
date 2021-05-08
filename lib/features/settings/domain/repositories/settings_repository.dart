import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/settings/data/datasources/settings_datasource.dart';

abstract class SettingsRepository extends BaseRepository {
  const SettingsRepository(SettingsDataSource settingsDataSource)
      : super(settingsDataSource);

  Future<NetworkResult<String>> sendOTP({String email, String password});

  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP(
      {String email, int code});

  Future<NetworkResult<bool>> changeEmail({String email, int code});

  Future<NetworkResult<bool>> changePassword(
      {String currentPassword, String newPassword, int id});
}
