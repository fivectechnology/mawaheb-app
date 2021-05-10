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
import 'package:dio/dio.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/profile/data/models/subscription_model.dart';
import 'package:mawaheb_app/features/profile/data/models/transaction_model.dart';

abstract class AuthRepository extends BaseRepository {
  const AuthRepository(AuthDataSource authDataSource) : super(authDataSource);

  Future<NetworkResult<PlayerModel>> login({
    required String userName,
    required String password,
    required String type,
    Dio? client,
  });

  Future<bool> logout();

  Future<NetworkResult<PlayerModel>> signUp({
    required String email,
    required String password,
    required int code,
    required String type,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> addPersonalInfo({
    required String? name,
    required int? id,
    required int? version,
    required String? dateOfBirth,
    required String? gender,
    required String? phone,
    required CountryModel? country,
    required CategoryModel? categoryModel,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> addAddressInfo({
    required int? id,
    required int? version,
    required EmirateModel? emirateModel,
    required String? area,
    required String? address,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> addSportInfo({
    required int? id,
    required int? version,
    required int? weight,
    required int? height,
    required String? hand,
    required String? leg,
    required SportModel? sport,
    required String? brief,
    required SportPositionModel? sportPositionModel,
  });

  Future<NetworkResult<ListBaseResponseModel<SportModel>?>> getSports();

  Future<NetworkResult<ListBaseResponseModel<SportPositionModel>?>> getPositions({int? sportId});

  Future<NetworkResult<ListBaseResponseModel<CountryModel>?>> getCountries();

  Future<NetworkResult<ListBaseResponseModel<CategoryModel>?>> getCategories();

  Future<NetworkResult<ListBaseResponseModel<EmirateModel>?>> getEmirates();

  Future<NetworkResult<String?>> sendOTP({
    required String? email,
  });

  Future<NetworkResult<BaseResponseModel<OTPResponseModel>?>> verifyOTP({
    required String? email,
    required int? code,
  });

  Future<int?> getPlayerId({String? token});

  Future<NetworkResult<bool?>> forgetPassword({String? email});

  Future<NetworkResult<bool?>> resetPassword({String? email, String? password, int? code});

  Future<NetworkResult<bool?>> validateEmail({String? email});

  Future<NetworkResult<ListBaseResponseModel<SubscriptionModel>?>> getSubscription();

  Future<NetworkResult<bool?>> subscriptionPlayer({int? playerId, int? subscriptionId});

  Future<NetworkResult<ListBaseResponseModel<TransactionModel>?>> playerTransaction({int? amount, int? playerId});

  Future<NetworkResult<ListBaseResponseModel<TransactionModel>?>> getPlayerTransaction();

  Future<NetworkResult<bool?>> confirmTransaction({int? transactionId, int? transactionVersion});
}
