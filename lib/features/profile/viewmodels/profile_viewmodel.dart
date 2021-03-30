import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';

part 'profile_viewmodel.g.dart';

@injectable
class ProfileViewmodel extends _ProfileViewmodelBase with _$ProfileViewmodel {
  ProfileViewmodel(
    Logger logger,
    ProfileRepository profileRepository,
  ) : super(logger, profileRepository);
}

abstract class _ProfileViewmodelBase extends BaseViewmodel with Store {
  _ProfileViewmodelBase(Logger logger, this._profileRepository) : super(logger);
  final ProfileRepository _profileRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
