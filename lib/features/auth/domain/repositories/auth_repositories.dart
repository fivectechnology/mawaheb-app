import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';

abstract class AuthRepository extends BaseRepository {
  const AuthRepository(AuthDataSource authDataSource) : super(authDataSource);
}
