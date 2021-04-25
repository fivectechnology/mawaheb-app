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

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateImageProfile({
    @required int id,
    @required int version,
    @required int imageId,
  });

  Future<int> uploadFile({
    @required File file,
    int fileSize,
    String fileName,
    String fileType,
  });

  Future<NetworkResult<bool>> uploadVideoPlayer({
    @required int playerId,
    @required int videoId,
  });

  Future<NetworkResult<bool>> deleteVideoPlayer({
    @required int videoVersion,
    @required int videoId,
  });

  Future<NetworkResult<bool>> replaceVideoPlayer({
    @required int videoVersion,
    @required int videoId,
    @required int videoFileId,
    @required int playerId,
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
        'data': {'criteria': [], 'operator': 'and'},
        'related': {
          'videos': ['id', 'video', 'status']
        },
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
          'availability',
          'photo',
          'membership'
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
        'fields': ['player', 'partner', 'partner.photo']
      },
      mapper: ListBaseResponseModel.fromJson(ViewModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateImageProfile({
    int id,
    int version,
    int imageId,
  }) {
    return mawahebRequest(
        method: METHOD.POST,
        mawahebModel: false,
        modelName: 'auth.db.User',
        withAuth: true,
        data: {
          'data': {
            'id': id,
            'version': version,
            'photo': {'id': imageId},
          },
          'fields': ['id', 'version', 'photo', 'name', 'email']
        },
        mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson));
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
  }

  @override
  Future<NetworkResult<bool>> uploadVideoPlayer({int playerId, int videoId}) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: true,
      modelName: 'PartnerVideo',
      data: {
        'data': {
          'partner': {'id': playerId},
          'video': {'id': videoId},
          'status': 'PENDING'
        },
      },
    );
  }

  @override
  Future<NetworkResult<bool>> deleteVideoPlayer(
      {int videoVersion, int videoId}) {
    return mawahebRequest(
      method: METHOD.DELETE,
      mawahebModel: true,
      modelName: 'PartnerVideo',
      id: videoId,
      data: {
        'data': {
          // 'partner': {'id': playerId},
          // 'video': {'id': videoId},
          'version': videoVersion
        },
      },
    );
  }

  @override
  Future<NetworkResult<bool>> replaceVideoPlayer(
      {int videoVersion, int videoId, int videoFileId, int playerId}) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: true,
      modelName: 'PartnerVideo',
      id: videoId,
      data: {
        'data': {
          'partner': {'id': playerId},
          'video': {'id': videoFileId},
          'version': videoVersion
        },
      },
    );
  }
}
