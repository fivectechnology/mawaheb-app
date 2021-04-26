import 'dart:convert';

import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/login_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';

abstract class AuthDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<BaseResponseModel<LoginResponseModel>>> login({
    @required String userName,
    @required String password,
    @required String type,
    Dio client,
  });

  Future<NetworkResult<BaseResponseModel<String>>> logout();

  Future<NetworkResult<bool>> validateEmail({@required String email});

  Future<NetworkResult<ListBaseResponseModel<SportModel>>> getSports();

  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>> getPositions();

  Future<NetworkResult<ListBaseResponseModel<CountryModel>>> getCountries();

  Future<NetworkResult<ListBaseResponseModel<CategoryModel>>> getCategories();

  Future<NetworkResult<ListBaseResponseModel<EmirateModel>>> getEmirates();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required int code,
    @required String email,
    @required String password,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addPersonalInfo({
    @required String name,
    @required int id,
    @required int version,
    @required String dateOfBirth,
    @required String gender,
    @required String phone,
    @required CountryModel country,
    @required CategoryModel categoryModel,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addAddressInfo({
    @required int id,
    @required int version,
    @required EmirateModel emirateModel,
    @required String area,
    @required String address,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addSportInfo({
    @required int id,
    @required int version,
    @required int weight,
    @required int height,
    @required String hand,
    @required String leg,
    @required String brief,
    @required SportModel sport,
    @required SportPositionModel sportPositionModel,
  });

  Future<NetworkResult<bool>> sendOTP({
    @required String email,
  });

  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP({
    @required String email,
    @required int code,
  });

  Future<NetworkResult<bool>> forgetPassword({
    @required String email,
  });

  Future<NetworkResult<bool>> resetPassword({@required String email, @required String password, @required int code});

  Future<int> getPlayerId({String token});
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl extends MawahebRemoteDataSource implements AuthDataSource {
  AuthDataSourceImpl({
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
  Future<NetworkResult<BaseResponseModel<LoginResponseModel>>> login({
    @required String userName,
    @required String password,
    @required String type,
    Dio client,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: '$BASE_PUBLIC_API/auth/login/$type',
      withAuth: false,
      mapper: BaseResponseModel.fromJson(LoginResponseModel.fromJson),
      data: {
        'data': {'username': userName, 'password': password}
      },
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<String>>> logout() {
    return mawahebRequest(
      method: METHOD.GET,
      endpoint: LOGIN_ENDPOINT,
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required int code,
    @required String email,
    @required String password,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      // endpoint: PROFILE_UPDATE_ENDPOINT,
      mawahebModel: false,
      modelName: 'auth.db.User',
      withAuth: true,
      data: {
        'data': {
          'group': {'id': 5, 'code': 'players'},
          'oldPassword': 'admin',
          'name': email.split('@').first,
          'code': email,
          'email': email,
          'newPassword': password,
          'chkPassword': password,
          'language': prefsRepository.languageCode,
          'blocked': false,
          'type': 'PLAYER',
          'status': 'INACTIVE',
          'otp': code,
        }
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addPersonalInfo({
    @required String name,
    @required int id,
    @required int version,
    @required CountryModel country,
    @required CategoryModel categoryModel,
    @required String dateOfBirth,
    @required String gender,
    @required String phone,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      withAuth: true,
      mawahebModel: false,
      modelName: 'auth.db.User',
      id: id,
      data: {
        'data': {
          'name': name,
          'version': version,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'phone': phone,
          'category': {'id': categoryModel.id},
          'country': {'id': country.id},
        }
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addAddressInfo({
    @required int id,
    @required int version,
    @required EmirateModel emirateModel,
    @required String area,
    @required String address,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: false,
      modelName: 'auth.db.User',
      id: id,
      withAuth: true,
      data: {
        'data': {
          'version': version,
          'emirate': {'id': emirateModel.id},
          'area': area,
          'address': address,
        }
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addSportInfo({
    @required int id,
    @required int version,
    @required int weight,
    @required int height,
    @required String hand,
    @required String leg,
    @required String brief,
    @required SportModel sport,
    @required SportPositionModel sportPositionModel,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      withAuth: true,
      mawahebModel: false,
      modelName: 'auth.db.User',
      id: id,
      data: {
        'data': {
          'version': version,
          'sport': {'id': sport.id},
          'position': {'id': sportPositionModel.id},
          'weight': weight,
          'height': height,
          'hand': hand,
          'leg': leg,
          'brief': brief,
        }
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<SportModel>>> getSports() {
    return mawahebRequest(
      modelName: 'Sport',
      method: METHOD.POST,
      action: EndPointAction.search,
      data: {
        'fields': ['id', 'version', 'name'],
      },
      mapper: ListBaseResponseModel.fromJson(SportModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<CategoryModel>>> getCategories() {
    return mawahebRequest(
      modelName: 'Category',
      method: METHOD.POST,
      action: EndPointAction.search,
      data: {
        'fields': ['id', 'version', 'title'],
      },
      mapper: ListBaseResponseModel.fromJson(CategoryModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<CountryModel>>> getCountries() {
    return mawahebRequest(
      modelName: 'Country',
      method: METHOD.POST,
      action: EndPointAction.search,
      data: {
        'fields': ['id', 'version', 'name'],
      },
      mapper: ListBaseResponseModel.fromJson(CountryModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<EmirateModel>>> getEmirates() {
    return mawahebRequest(
      modelName: 'Emirate',
      method: METHOD.POST,
      action: EndPointAction.search,
      data: {
        'fields': ['id', 'version', 'name'],
      },
      mapper: ListBaseResponseModel.fromJson(EmirateModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>> getPositions() {
    return mawahebRequest(
      modelName: 'SportPosition',
      method: METHOD.POST,
      action: EndPointAction.search,
      data: {
        'fields': ['id', 'version', 'name'],
      },
      mapper: ListBaseResponseModel.fromJson(SportPositionModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<bool>> sendOTP({String email}) {
    return mawahebRequest(
      endpoint: OTP_SEND_ENDPOINT,
      method: METHOD.POST,
      data: {'data': email},
    );
  }

  @override
  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP({String email, int code}) {
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
  Future<int> getPlayerId({String token}) async {
    final Response response = await client.get(
      '$BASE_API$WEB_SERVICE/app/info',
      options: Options(headers: {'Authorization': 'Basic $token'}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.data)['user.id'] as int;
    }

    return null;
    // return response.data['user.id'] as int;
  }

  @override
  Future<NetworkResult<bool>> forgetPassword({String email}) {
    return mawahebRequest(
        method: METHOD.POST,
        endpoint: BASE_API + WEB_SERVICE + PUBLIC_SERVICE + '/auth/password/forgot',
        data: {'data': email},
        mapper: BaseResponseModel.successMapper);
  }

  @override
  Future<NetworkResult<bool>> resetPassword({String email, String password, int code}) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: BASE_PUBLIC_API + '/auth/password/forgot/update',
      data: {
        'data': {'username': email, 'password': password, 'code': code}
      },
    );
  }

  @override
  Future<NetworkResult<bool>> validateEmail({String email}) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: BASE_PUBLIC_API + '/auth/email/validate/unique',
      data: {'data': email},
      mapper: BaseResponseModel.successMapper,
    );
  }
}
