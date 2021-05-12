import 'dart:io';

import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/network_result.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';

abstract class ProfileDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> fetchProfile({
    required int? id,
  });

  Future<NetworkResult<ListBaseResponseModel<ViewModel>?>> playerViews({
    required int? id,
    required int limit,
    required int offset,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> updateImageProfile({
    required int? id,
    required int? version,
    required int? imageId,
  });

  Future<NetworkResult<int>> uploadFile({required File? file});

  Future<NetworkResult<ListBaseResponseModel<VideoModel>?>> fetchPlayerVideos({required int? playerId});

  Future<NetworkResult<bool?>> uploadVideoPlayer({
    required int? playerId,
    required int? videoId,
  });

  Future<NetworkResult<bool?>> deleteVideoPlayer({
    required int? videoVersion,
    required int? videoId,
  });

  Future<NetworkResult<bool?>> replaceVideoPlayer({
    required int? videoVersion,
    required int? videoId,
    required int? videoFileId,
    required int? playerId,
  });

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> updateSportInfo({
    required int? id,
    required int? version,
    required int? weight,
    required int? height,
    required String? hand,
    required String? leg,
    required String? brief,
    required SportModel? sport,
    required SportPositionModel? sportPositionModel,
  });
}

@LazySingleton(as: ProfileDataSource)
class ProfileDataSourceImpl extends MawahebRemoteDataSource implements ProfileDataSource {
  ProfileDataSourceImpl({
    required Dio client,
    required PrefsRepository? prefsRepository,
    required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          logger: logger,
        );

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> fetchProfile({int? id}) {
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
          'videos': ['id', 'video', 'status'],
          'subscription': ['startedAt', 'finishAt', 'subscription.name'],
          'category': ['title']
        },
        'fields': [
          'country',
          'subscription',
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
          'photo.fileUUID',
          'membership',
          'language',
          'fullNameAr'
        ]
      },
      mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<ViewModel>?>> playerViews({
    int? id,
    required int limit,
    required int offset,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: 'ProfileView',
      action: EndPointAction.search,
      data: {
        'limit': limit,
        'offset': offset,
        'data': {
          'criteria': [
            {'fieldName': 'player.id', 'value': id, 'operator': '='}
          ],
          'operator': 'and'
        },
        'fields': ['player', 'partner', 'partner.photo.fileUUID', 'partner.type']
      },
      mapper: ListBaseResponseModel.fromJson(ViewModel.fromJson),
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> updateImageProfile({
    int? id,
    int? version,
    int? imageId,
  }) async {
    return mawahebRequest(
        method: METHOD.POST,
        mawahebModel: false,
        modelName: 'auth.db.User',
        withAuth: true,
        id: id,
        data: {
          'data': {
            'id': id,
            'version': (await getVersion(
              modelId: id,
              modelName: 'auth.db.User',
              mawahebModel: false,
              asList: true,
            ))
                .getOrThrow()!
                .version,
            'photo': {'id': imageId},
          },
          'fields': ['id', 'version', 'photo', 'name', 'email']
        },
        mapper: ListBaseResponseModel.fromJson(PlayerModel.fromJson));
  }

  @override
  Future<NetworkResult<int>> uploadFile({required File? file}) async {
    return mawahebRequest<List<int?>?>(
      method: METHOD.POST,
      modelName: 'meta.db.MetaFile',
      mawahebModel: false,
      action: EndPointAction.upload,
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file!.path,
          filename: file.path.split('/').last,
        ),
        'request': '{}',
        'field': '',
      }),
      mapper: ListBaseResponseModel.dataTypeMapper((json) => (json as Map<String, dynamic>)['id'] as int?),
    ).whenSuccessWrapped((res) => res!.first!);
  }

  @override
  Future<NetworkResult<bool?>> uploadVideoPlayer({int? playerId, int? videoId}) {
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
  Future<NetworkResult<bool?>> deleteVideoPlayer({int? videoVersion, int? videoId}) {
    return mawahebRequest(
      method: METHOD.DELETE,
      mawahebModel: true,
      modelName: 'PartnerVideo',
      mapper: BaseResponseModel.successMapper,
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
  Future<NetworkResult<bool?>> replaceVideoPlayer({int? videoVersion, int? videoId, int? videoFileId, int? playerId}) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: true,
      modelName: 'PartnerVideo',
      id: videoId,
      data: {
        'data': {
          'partner': {'id': playerId},
          'video': {'id': videoFileId},
          'status': 'PENDING',
          'version': videoVersion
        },
      },
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<VideoModel>?>> fetchPlayerVideos({int? playerId}) {
    return mawahebRequest(
        method: METHOD.POST,
        modelName: 'PartnerVideo',
        action: EndPointAction.search,
        data: {
          'data': {
            'criteria': [
              {'fieldName': 'partner.id', 'operator': '=', 'value': playerId}
            ],
            'operator': 'AND'
          },
          'fields': ['partner', 'status', 'video', 'video.fileUUID']
        },
        mapper: ListBaseResponseModel.fromJson(VideoModel.fromJson));
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> updateSportInfo({
    required int? id,
    required int? version,
    required int? weight,
    required int? height,
    required String? hand,
    required String? leg,
    required String? brief,
    required SportModel? sport,
    required SportPositionModel? sportPositionModel,
  }) async {
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
              .getOrThrow()!
              .version,
          'sport': {'id': sport!.id},
          'position': {'id': sportPositionModel!.id},
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
}
