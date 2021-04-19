import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';

abstract class ProfileRepository extends BaseRepository {
  const ProfileRepository(ProfileDataSource profileDataSource)
      : super(profileDataSource);

  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchPlayer();
}
