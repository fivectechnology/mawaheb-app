import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl(this.authDataSource) : super(authDataSource);

  final AuthDataSource authDataSource;
}
