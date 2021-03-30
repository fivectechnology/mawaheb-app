import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/extensions/string.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';

part 'public_info_viewmodels.g.dart';

@injectable
class PublicInfoViewmodel extends _PublicInfoViewmodelBase with _$PublicInfoViewmodel {
  PublicInfoViewmodel(
    Logger logger,
    PublicInfoRepository publicinfoRepository,
  ) : super(logger, publicinfoRepository);
}

abstract class _PublicInfoViewmodelBase extends BaseViewmodel with Store {
  _PublicInfoViewmodelBase(Logger logger, this._publicinfoRepository) : super(logger);
  final PublicInfoRepository _publicinfoRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
