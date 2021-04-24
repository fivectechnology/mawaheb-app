import 'package:core_sdk/error/exceptions.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/data/models/user_model.dart';
import 'package:mawaheb_app/base/domain/repositories/app_repository.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl(
    this.authDataSource,
    this._prefsRepository,
    this._appRepository,
    this._profileRepository,
  ) : super(authDataSource);

  final AuthDataSource authDataSource;
  final PrefsRepository _prefsRepository;
  final AppRepository _appRepository;
  final ProfileRepository _profileRepository;

  @override
  Future<NetworkResult<PlayerModel>> login({
    @required String userName,
    @required String password,
    @required String type,
  }) =>
      _prefsRepository
          .setType(type)
          .then((res) => _prefsRepository.setToken(null))
          .then((res) => res ? _appRepository.registerDevice() : throw Exception(''))
          .then((res) => res ? authDataSource.login(userName: userName, password: password) : throw Exception(''))
          .whenSuccess((res) => _prefsRepository.setToken(res.data.data))
          .then((res) =>
              res ? _prefsRepository.setUser(UserModel(userName: userName, password: password)) : throw Exception(''))
          .then((res) => getPlayerId(token: _prefsRepository.token))
          .then((res) => _profileRepository.fetchPlayer(id: res))
          .whenSuccessWrapped((res) async {
        await _appRepository.modifyDevice(true);
        await _prefsRepository.setPlayer(res.data.first);
        return res.data.first;
      });

  @override
  Future<bool> logout() async {
    try {
      final result = await _appRepository.modifyDevice(false);
      if (!result) {
        throw ServerException('Failed to unlink device!');
      }
      await _prefsRepository.clearUserData();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<NetworkResult<PlayerModel>> signUp({
    @required int code,
    @required String email,
    @required String password,
    @required String type,
  }) =>
      _prefsRepository
          .setType(type)
          .then((res) => authDataSource.signUp(code: code, email: email, password: password))
          .then((res) => login(password: password, userName: email, type: type));

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addAddressInfo({
    @required int id,
    @required int version,
    @required EmirateModel emirateModel,
    @required String area,
    @required String address,
  }) =>
      authDataSource.addAddressInfo(id: id, version: version, emirateModel: emirateModel, area: area, address: address);

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> addPersonalInfo({
    @required String name,
    @required int id,
    @required int version,
    @required String dateOfBirth,
    @required String gender,
    @required String phone,
    @required CountryModel country,
    @required CategoryModel categoryModel,
  }) =>
      authDataSource.addPersonalInfo(
          name: name,
          id: id,
          version: version,
          categoryModel: categoryModel,
          country: country,
          dateOfBirth: dateOfBirth,
          gender: gender,
          phone: phone);

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
  }) =>
      authDataSource.addSportInfo(
        id: id,
        version: version,
        weight: weight,
        height: height,
        hand: hand,
        leg: leg,
        sport: sport,
        brief: brief,
        sportPositionModel: sportPositionModel,
      );

  @override
  Future<NetworkResult<ListBaseResponseModel<CategoryModel>>> getCategories() => authDataSource.getCategories();

  @override
  Future<NetworkResult<ListBaseResponseModel<CountryModel>>> getCountries() => authDataSource.getCountries();

  @override
  Future<NetworkResult<ListBaseResponseModel<EmirateModel>>> getEmirates() => authDataSource.getEmirates();

  @override
  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>>> getPositions() => authDataSource.getPositions();

  @override
  Future<NetworkResult<ListBaseResponseModel<SportModel>>> getSports() => authDataSource.getSports();

  @override
  Future<NetworkResult<bool>> sendOTP({String email}) => authDataSource.sendOTP(email: email);

  @override
  Future<NetworkResult<BaseResponseModel<OTPResponseModel>>> verifyOTP({String email, int code}) =>
      authDataSource.verifyOTP(email: email, code: code);

  @override
  Future<int> getPlayerId({String token}) => authDataSource.getPlayerId(token: token);

  @override
  Future<NetworkResult<bool>> forgetPassword({String email}) => authDataSource.forgetPassword(email: email);

  @override
  Future<NetworkResult<bool>> resetPassword({String email, String password, int code}) =>
      authDataSource.resetPassword(email: email, password: password, code: code);

  @override
  Future<NetworkResult<bool>> validateEmail({String email}) => authDataSource.validateEmail(email: email);
}
