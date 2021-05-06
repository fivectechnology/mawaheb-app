import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';

abstract class SettingsDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<bool>> sendOTP({
    @required String email,
    @required String password,
  });

  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP({
    @required String email,
    @required int code,
  });

  Future<NetworkResult<bool>> changeEmail({
    @required String email,
    @required int code,
  });

  Future<NetworkResult<bool>> changePassword({
    @required String currentPassword,
    @required String newPassword,
    @required int id,
  });
  Future<NetworkResult<bool>> updateLanguage({
    @required int id,
    @required String language,
  });
}

@LazySingleton(as: SettingsDataSource)
class SettingsDataSourceImpl extends MawahebRemoteDataSource
    implements SettingsDataSource {
  SettingsDataSourceImpl({
    @required Dio client,
    @required PrefsRepository prefsRepository,
    @required DataConnectionChecker connectionChecker,
    @required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          connectionChecker: connectionChecker,
          logger: logger,
        );

  @override
  Future<NetworkResult<bool>> sendOTP({String email, String password}) {
    return mawahebRequest(
        endpoint: BASE_API + WEB_SERVICE + '/auth/email/change',
        method: METHOD.POST,
        data: {
          'data': {
            'email': email,
            'currentPassword': password,
          }
        },
        mapper: BaseResponseModel.successMapper);
  }

  @override
  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP(
      {String email, int code}) {
    return mawahebRequest(
      endpoint: OTP_VERIFY_ENDPOINT,
      method: METHOD.POST,
      data: {
        'data': {
          'key': email,
          'code': code,
        }
      },
      mapper: BaseResponseModel.fromJson(OTPResponseModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<bool>> changeEmail({String email, int code}) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: BASE_API + WEB_SERVICE + '/auth/email/change/update',
      data: {
        'data': {
          'email': email,
          'code': code,
        }
      },
    );
  }

  @override
  Future<NetworkResult<bool>> changePassword(
      {String currentPassword, String newPassword, int id}) {
    return mawahebRequest(
        method: METHOD.POST,
        modelName: 'auth.db.User',
        mawahebModel: false,
        data: {
          'data': {
            'id': id,
            'oldPassword': currentPassword,
            'newPassword': newPassword,
            'chkPassword': newPassword
          }
        },
        mapper: BaseResponseModel.successMapper);
  }

  @override
  Future<NetworkResult<bool>> updateLanguage({int id, String language}) async {
    return mawahebRequest(
      method: METHOD.POST,
      withAuth: true,
      mawahebModel: false,
      modelName: 'auth.db.User',
      id: id,
      data: {
        'data': {
          'version': (await getVersion(
            modelId: id,
            modelName: 'auth.db.User',
            mawahebModel: false,
            asList: true,
          ))
              .getOrThrow()
              .version,
          'language': language,
          'id': id
        }
      },
    );
  }
}
