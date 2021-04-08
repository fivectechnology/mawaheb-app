import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:supercharged/supercharged.dart';

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
  //
  // String get tabTitle {
  //   switch (tabsIndex) {
  //     case PublicInfoTabs.about_us:
  //       return 'About us';
  //     case PublicInfoTabs.gallery:
  //       return 'Gallery';
  //     case PublicInfoTabs.contacts:
  //       return 'Contacts';
  //     case PublicInfoTabs.strategic_partners:
  //       return 'Strategic Partners';
  //     case PublicInfoTabs.download_center:
  //       return 'Download Center';
  //     default:
  //       return 'not_exist';
  //   }
  // }
  //
  // //* OBSERVERS *//
  //
  // @observable
  // PublicInfoTabs tabsIndex = PublicInfoTabs.about_us;
  //
  // @observable
  // ObservableFuture<ListBaseResponseModel<AboutUsModel>> aboutUsFuture;
  //
  // @observable
  // ObservableFuture<ContactUsModel> contactUsFuture;
  //
  // //* COMPUTED *//
  //
  // @computed
  // ListBaseResponseModel<AboutUsModel> get aboutUs => aboutUsFuture?.value;
  //
  // @computed
  // ContactUsModel get contactUs => contactUsFuture?.value;
  //
  // //* ACTIONS *//
  //
  // @action
  // void getaboutUs() => aboutUsFuture = futureWrapper(
  //       () => _publicinfoRepository.getAboutUs().whenSuccess((res) => res.data),
  //       catchBlock: (err) => showSnack(err, duration: 2.seconds),
  //     );
  //
  // @action
  // void getcontactUs() => contactUsFuture = futureWrapper(
  //       () => _publicinfoRepository.getContactUs().whenSuccess((res) => res.data),
  //       catchBlock: (err) => showSnack(err, duration: 2.seconds),
  //     );
}
