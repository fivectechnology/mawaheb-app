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
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';

abstract class AuthDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<bool>> login(
      {@required String userName, @required String password});

  Future<NetworkResult<BaseResponseModel<String>>> logout();

  Future<NetworkResult<ListBaseResponseModel<SportModel>>> getSports();

  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>>
      getPositions();

  Future<NetworkResult<ListBaseResponseModel<CountryModel>>> getCountries();

  Future<NetworkResult<ListBaseResponseModel<CategoryModel>>> getCategories();

  Future<NetworkResult<ListBaseResponseModel<EmirateModel>>> getEmirates();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required String userName,
    @required String code,
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

  Future<NetworkResult<BaseResponseModel<String>>> verifyOTP({
    @required String email,
    @required int code,
  });
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl extends MawahebRemoteDataSource
    implements AuthDataSource {
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
  Future<NetworkResult<bool>> login({
    @required String userName,
    @required String password,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      endpoint: LOGIN_ENDPOINT,
      withAuth: false,
      data: {'username': userName, 'password': password},
    );
  }

  // TODO(ahmad): need test
  @override
  Future<NetworkResult<BaseResponseModel<String>>> logout() {
    return mawahebRequest(
      method: METHOD.GET,
      endpoint: LOGIN_ENDPOINT,
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required String userName,
    @required String code,
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
          'code': code,
          'name': userName,
          'email': email,
          'newPassword': password,
          'chkPassword': password,
          'language': 'en',
          'blocked': false,
          'type': 'PLAYER',
          'status': 'INACTIVE'
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
      modelName: 'auth.db.User/',
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
      withAuth: true,
      mawahebModel: false,
      modelName: 'auth.db.User/',
      id: id,
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
      modelName: 'auth.db.User/',
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
  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>>
      getPositions() {
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
  Future<NetworkResult<BaseResponseModel<String>>> verifyOTP(
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
      mapper: BaseResponseModel.fromJson((obj) => obj as String),
    );
  }
}
