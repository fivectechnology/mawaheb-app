import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  const ProfileRepositoryImpl(this.profileDataSource) : super(profileDataSource);
  final ProfileDataSource profileDataSource;
}
