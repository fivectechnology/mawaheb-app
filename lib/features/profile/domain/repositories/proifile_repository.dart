import 'dart:io';

import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';

abstract class ProfileRepository extends BaseRepository {
  const ProfileRepository(ProfileDataSource profileDataSource) : super(profileDataSource);

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchPlayer({int id});

  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateImageProfile({
    int id,
    int version,
    int imageId,
  });

  Future<NetworkResult<int>> uploadFile({@required File file});

  Future<NetworkResult<bool>> uploadVideoPlayer({int playerId, int videoId});

  Future<NetworkResult<bool>> deleteVideoPlayer({int videoVersion, int videoId});

  Future<NetworkResult<bool>> replaceVideoPlayer({int videoVersion, int videoId, int videoFileId, int playerId});

  Future<NetworkResult<ListBaseResponseModel<VideoModel>>> fetchPlayerVideos({int playerId});

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateSportInfo({
    int id,
    int version,
    int weight,
    int height,
    String hand,
    String leg,
    String brief,
    SportModel sport,
    sportPositionModel,
  });
}
