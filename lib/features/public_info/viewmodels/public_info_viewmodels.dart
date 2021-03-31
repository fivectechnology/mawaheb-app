import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';

part 'public_info_viewmodels.g.dart';

enum PublicInfoTabs {
  about_us,
  gallery,
  contacts,
  strategic_partners,
  download_center
}

@injectable
class PublicInfoViewmodel extends _PublicInfoViewmodelBase
    with _$PublicInfoViewmodel {
  PublicInfoViewmodel(
    Logger logger,
    PublicInfoRepository publicinfoRepository,
  ) : super(logger, publicinfoRepository);
}

abstract class _PublicInfoViewmodelBase extends BaseViewmodel with Store {
  _PublicInfoViewmodelBase(Logger logger, this._publicinfoRepository)
      : super(logger);
  final PublicInfoRepository _publicinfoRepository;

//* OBSERVERS *//
  @observable
  PublicInfoTabs tabsIndex = PublicInfoTabs.about_us;

//* COMPUTED *//

//* ACTIONS *//

  String get _tabTitle {
    switch (tabsIndex) {
      case PublicInfoTabs.about_us:
        return 'About us';
      case PublicInfoTabs.gallery:
        return 'Gallery';
      case PublicInfoTabs.contacts:
        return 'Contacts';
      case PublicInfoTabs.strategic_partners:
        return 'Strategic Partners';
      case PublicInfoTabs.download_center:
        return 'Download Center';
      default:
        return 'not_exist';
    }
  }
}
