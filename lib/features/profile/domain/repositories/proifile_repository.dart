import 'dart:io';

import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';

abstract class ProfileRepository extends BaseRepository {
  const ProfileRepository(ProfileDataSource profileDataSource)
      : super(profileDataSource);

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchPlayer(
      {int id});

  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews();

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateImageProfile({
    int id,
    int version,
    int imageId,
  });

  Future<int> uploadFile({
    File file,
    int fileSize,
    String fileName,
    String fileType,
  });

  Future<NetworkResult<bool>> uploadVideoPlayer({int playerId, int videoId});
}
