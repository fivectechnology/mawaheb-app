import 'dart:io';

import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';

abstract class ProfileDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchProfile({
    @required int id,
  });

  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews({
    @required int id,
  });

  Future<NetworkResult<bool>> updateImageProfile({
    @required int id,
    @required int version,
    @required String image,
  });

  Future<int> uploadFile({
    @required File file,
    int fileSize,
    String fileName,
    String fileType,
  });
}

@LazySingleton(as: ProfileDataSource)
class ProfileDataSourceImpl extends MawahebRemoteDataSource
    implements ProfileDataSource {
  ProfileDataSourceImpl({
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
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchProfile(
      {int id}) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: false,
      modelName: 'auth.db.User',
      action: EndPointAction.fetch,
      withAuth: true,
      id: id,
      data: {
        'fields': [
          'country',
          'subscriptions',
          'currentSubscription',
          'videos',
          'type',
          'leg',
          'height',
          'area',
          'weight',
          'phone',
          'name',
          'position',
          'status',
          'gender',
          'brief',
          'hand',
          'address',
          'dateOfBirth',
          'emirate',
          'category',
          'sport',
          'viewers',
          'availability'
        ]
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews(
      {int id}) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: 'ProfileView',
      action: EndPointAction.search,
      data: {
        'data': {
          'criteria': [
            {'fieldName': 'player.id', 'value': id, 'operator': '='}
          ],
          'operator': 'and'
        },
        'fields': ['player', 'partner']
      },
      mapper: ListBaseResponseModel.fromJson(ViewModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<bool>> updateImageProfile({
    int id,
    int version,
    String image,
  }) {
    return mawahebRequest(
        method: METHOD.POST,
        mawahebModel: false,
        modelName: 'auth.db.User',
        withAuth: true,
        data: {
          'data': {'id': id, 'version': version, 'image': image}
        });
  }

  @override
  Future<int> uploadFile({
    File file,
    int fileSize,
    String fileName,
    String fileType,
  }) async {
    final Dio dio = Dio();
    int id;
    final Response response =
        await dio.post(BASE_API + WEB_SERVICE + '/files/upload',
            data: file.openRead(),
            options: Options(headers: {
              'Authorization': 'Basic ${prefsRepository.token}',
              'Content-Type': 'application/octet-stream',
              'X-File-Offset': 0,
              'X-File-Size': fileSize,
              'Content-Length': fileSize,
              'X-File-Name': fileName,
              'X-File-Type': 'image/' + fileType
            }));

    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      id = data['id'] as int;
      print(id);
    }

    return id;

    // return mawahebRequest(
    //     mawahebModel: false,
    //     method: METHOD.POST,
    //     endpoint: BASE_API + WEB_SERVICE + '/files/upload',
    //     data: file,
    //     headers: {
    //       'Content-Type': 'application/octet-stream',
    //       'X-File-Offset': 0,
    //       'X-File-Size': fileSize,
    //       'Content-Length': fileSize,
    //       'X-File-Name': fileName,
    //       'X-File-Type': 'image/' + fileType
    //     });
  }
}
