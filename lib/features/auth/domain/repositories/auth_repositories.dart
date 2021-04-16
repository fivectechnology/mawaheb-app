import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';

abstract class AuthRepository extends BaseRepository {
  const AuthRepository(AuthDataSource authDataSource) : super(authDataSource);

  Future<NetworkResult<bool>> login(
      {@required String userName, @required String password});

  Future<bool> logout();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> signUp({
    @required String displayName,
    @required String code,
    @required String email,
    @required String password,
    @required int otp,
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
    @required SportModel sport,
    @required String brief,
    @required SportPositionModel sportPositionModel,
  });

  Future<NetworkResult<ListBaseResponseModel<SportModel>>> getSports();

  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>>
      getPositions();

  Future<NetworkResult<ListBaseResponseModel<CountryModel>>> getCountries();

  Future<NetworkResult<ListBaseResponseModel<CategoryModel>>> getCategories();

  Future<NetworkResult<ListBaseResponseModel<EmirateModel>>> getEmirates();

  Future<NetworkResult<bool>> sendOTP({
    @required String email,
  });

  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP({
    @required String email,
    @required int code,
  });
}
