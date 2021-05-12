import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';

abstract class PlayersDataSource extends BaseRemoteDataSource {
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> searchPlayers({
    required int offset,
    required int limit,
    required int countryId,
    required int sportId,
    required int positionId,
    required String? hand,
    required String? leg,
    required String? name,
    required int partnerId,
    required bool isConfirmed,
    required bool isBooked,
  });

  Future<NetworkResult<bool?>> viewPlayerProfile({required int? id});

  Future<NetworkResult<bool?>> bookPlayer({required int? playerId, required int? partnerId});

  Future<NetworkResult<bool?>> confirmPlayer({
    required int? memberShipId,
    required int? memberShipVersion,
  });

  Future<NetworkResult<bool?>> releasePlayer({
    required int? memberShipId,
    required int? memberShipVersion,
  });

  Future<NetworkResult<ListBaseResponseModel<VideoModel>?>> fetchApprovedVideos({required int? playerId});

// Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
//     getMemberShips({
//   @required int partnerId,
// });
}

@LazySingleton(as: PlayersDataSource)
class PlayersDataSourceImpl extends MawahebRemoteDataSource implements PlayersDataSource {
  PlayersDataSourceImpl({
    required Dio client,
    required PrefsRepository prefsRepository,
    required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          logger: logger,
        );

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>?>> searchPlayers({
    required int offset,
    required int limit,
    required int countryId,
    required int sportId,
    required int positionId,
    required String? hand,
    required String? leg,
    required String? name,
    required int partnerId,
    required bool isConfirmed,
    required bool isBooked,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      mawahebModel: false,
      modelName: 'auth.db.User',
      action: EndPointAction.search,
      data: {
        'limit': limit,
        'offset': offset,
        'data': {
          'criteria': [
            {'fieldName': 'type', 'operator': '=', 'value': 'PLAYER'},
            {'fieldName': 'blocked', 'operator': '=', 'value': false},
            {'fieldName': 'status', 'operator': '=', 'value': 'ACTIVE'},
            // {'fieldName': 'blocked', 'operator': '=', 'value': false},
            // {'fieldName': 'status', 'operator': '=', 'value': 'INACTIVE'},
            // {'fieldName': 'availability', 'operator': '=', 'value': 'RELEASED'}
            if (name != '' && name != null) {'fieldName': 'name', 'operator': 'like', 'value': name},

            if (countryId != 0 && countryId != null) {'fieldName': 'country.id', 'operator': '=', 'value': countryId},

            if (sportId != 0 && sportId != null) {'fieldName': 'sport.id', 'operator': '=', 'value': sportId},

            if (positionId != 0 && positionId != null)
              {'fieldName': 'position.id', 'operator': '=', 'value': positionId},
            if (hand != '' && hand != null) {'fieldName': 'hand', 'operator': '=', 'value': hand},
            if (leg != null && leg != '') {'fieldName': 'leg', 'operator': '=', 'value': leg},
            if (isBooked) {'fieldName': 'availability', 'operator': '=', 'value': 'BOOKED'},
            if (isConfirmed) {'fieldName': 'availability', 'operator': '=', 'value': 'CONFIRMED'},

            if (isBooked || isConfirmed) {'fieldName': 'partners.partner.id', 'operator': '=', 'value': partnerId}
          ],
          'operator': 'and'
        },
        'fields': ['name', 'id', 'photo.fileUUID', 'availability']
      },
      mapper:
          ListBaseResponseModel.fromJson(PlayerModel.fromJson) as ListBaseResponseModel<PlayerModel> Function(Object?)?,
    );
  }

  @override
  Future<NetworkResult<bool?>> viewPlayerProfile({required int? id}) {
    return mawahebRequest(
        method: METHOD.POST,
        mawahebModel: false,
        modelName: 'auth.db.User',
        action: EndPointAction.fetch,
        mapper: BaseResponseModel.successMapper,
        id: id,
        data: {
          'data': {
            'criteria': [],
            'operator': 'and',
            'operation': 'VIEW_PLAYER_PROFILE',
          },
          'fields': ['name', 'id']
        });
  }

  @override
  Future<NetworkResult<bool?>> bookPlayer({int? playerId, int? partnerId}) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: 'Membership',
      mapper: BaseResponseModel.successMapper,
      data: {
        'data': {
          'partner': {'id': partnerId},
          'player': {'id': playerId},
          'status': 'BOOKED'
        }
      },
    );
  }

  @override
  Future<NetworkResult<bool?>> confirmPlayer({
    required int? memberShipId,
    required int? memberShipVersion,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      id: memberShipId,
      mapper: BaseResponseModel.successMapper,
      modelName: 'Membership',
      data: {
        'data': {'version': memberShipVersion, 'status': 'CONFIRMED'},
        'fields': ['partner', 'player', 'status', 'version']
      },
    );
  }

  @override
  Future<NetworkResult<bool?>> releasePlayer({
    required int? memberShipId,
    required int? memberShipVersion,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      id: memberShipId,
      mapper: BaseResponseModel.successMapper,
      modelName: 'Membership',
      data: {
        'data': {'version': memberShipVersion, 'status': 'RELEASED'},
        'fields': ['partner', 'player', 'status', 'version']
      },
    );
  }

  @override
  Future<NetworkResult<ListBaseResponseModel<VideoModel>?>> fetchApprovedVideos({int? playerId}) {
    return mawahebRequest(
        method: METHOD.POST,
        modelName: 'PartnerVideo',
        action: EndPointAction.search,
        data: {
          'data': {
            'criteria': [
              {'fieldName': 'partner.id', 'operator': '=', 'value': playerId},
              {'fieldName': 'status', 'operator': '=', 'value': 'APPROVED'}
            ],
            'operator': 'AND'
          },
          'fields': ['status', 'video', 'video.fileUUID']
        },
        mapper: ListBaseResponseModel.fromJson(VideoModel.fromJson) as ListBaseResponseModel<VideoModel> Function(
            Object?)?);
  }

// @override
// Future<NetworkResult<ListBaseResponseModel<PartnerMemberModel>>>
//     getMemberShips({int partnerId}) {
//   return mawahebRequest(
//     method: METHOD.POST,
//     modelName: 'Membership',
//     action: EndPointAction.search,
//     data: {
//       'data': {
//         'criteria': [
//           {'fieldName': 'partner.id', 'operator': '=', 'value': partnerId},
//           {'fieldName': 'status', 'operator': '=', 'value': 'CONFIRMED'}
//         ],
//         'operator': 'and'
//       },
//       'fields': ['version', 'player', 'status']
//     },
//     mapper: ListBaseResponseModel.fromJson(PartnerMemberModel.fromJson),
//   );
// }
}
