import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';

abstract class ProfileRepository extends BaseRepository {
  const ProfileRepository(ProfileDataSource profileDataSource) : super(profileDataSource);
}
