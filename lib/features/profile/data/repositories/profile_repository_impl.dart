import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  const ProfileRepositoryImpl(this.profileDataSource, this._prefsRepository)
      : super(profileDataSource);
  final ProfileDataSource profileDataSource;
  final PrefsRepository _prefsRepository;

  @override
  Future<NetworkResult<ListBaseResponseModel<PlayerModel>>> fetchPlayer() =>
      profileDataSource.fetchProfile(id: _prefsRepository.player.id);

  @override
  Future<NetworkResult<ListBaseResponseModel<ViewModel>>> playerViews() =>
      profileDataSource.playerViews(id: _prefsRepository.player.id);
}
