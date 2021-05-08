import 'dart:io';

import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  const ProfileRepositoryImpl(this.profileDataSource, this._prefsRepository)
      : super(profileDataSource);
  final ProfileDataSource profileDataSource;
  final PrefsRepository _prefsRepository;

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchPlayer(
          {int id}) =>
      profileDataSource.fetchProfile(id: id);

  @override
  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews() =>
      profileDataSource.playerViews(id: _prefsRepository.player.id);

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateImageProfile(
          {int id, int version, int imageId}) =>
      profileDataSource.updateImageProfile(
          id: id, version: version, imageId: imageId);

  @override
  Future<NetworkResult<int>> uploadFile({@required File file}) =>
      profileDataSource.uploadFile(file: file);

  @override
  Future<NetworkResult<bool>> uploadVideoPlayer({int playerId, int videoId}) =>
      profileDataSource.uploadVideoPlayer(playerId: playerId, videoId: videoId);

  @override
  Future<NetworkResult<bool>> deleteVideoPlayer(
          {int videoVersion, int videoId}) =>
      profileDataSource.deleteVideoPlayer(
          videoVersion: videoVersion, videoId: videoId);

  @override
  Future<NetworkResult<bool>> replaceVideoPlayer(
          {int videoVersion, int videoId, int videoFileId, int playerId}) =>
      profileDataSource.replaceVideoPlayer(
          videoVersion: videoVersion,
          videoId: videoId,
          videoFileId: videoFileId,
          playerId: playerId);

  @override
  Future<NetworkResult<ListBaseResponseModel<VideoModel>>> fetchPlayerVideos(
          {int playerId}) =>
      profileDataSource.fetchPlayerVideos(playerId: playerId);

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> updateSportInfo(
          {int id,
          int version,
          int weight,
          int height,
          String hand,
          String leg,
          String brief,
          SportModel sport,
          sportPositionModel}) =>
      profileDataSource.updateSportInfo(
          id: id,
          version: version,
          weight: weight,
          height: height,
          hand: hand,
          leg: leg,
          brief: brief,
          sport: sport,
          sportPositionModel: sportPositionModel);
}
