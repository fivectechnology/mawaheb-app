import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/login/ui/pages/login_page.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/download_center_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/gallery_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/strategic_partners_model.dart';
import 'package:mawaheb_app/features/public_info/domain/repositories/public_info_repository.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/about_us_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/contacts_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/download_center_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/gallery_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/strategic_partners_page.dart';
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
    PrefsRepository prefsRepository,
  ) : super(logger, publicinfoRepository, prefsRepository);
}

abstract class _PublicInfoViewmodelBase extends BaseViewmodel with Store {
  _PublicInfoViewmodelBase(
      Logger logger, this._publicinfoRepository, this.prefsRepository)
      : super(logger);
  final PublicInfoRepository _publicinfoRepository;
  final PrefsRepository prefsRepository;

  List<Widget> tabs = [];

  List<Widget> pages = [
    const AboutUsPage(),
    const GalleryPage(),
    const ContactsPage(),
    const StrategicPartnersPage(),
    const DownLoadCenterPage()
  ];

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
  @observable
  ObservableFuture<AboutUsModel> aboutUsFuture;

  @observable
  ObservableFuture<ContactUsModel> contactsFuture;

  @observable
  ObservableFuture<GalleryModel> galleryFuture;

  @observable
  ObservableFuture<StrategicPartnersModel> partnersFuture;

  @observable
  ObservableFuture<DownloadCenterModel> downloadsFuture;

  @observable
  bool isLoggedIn = false;
  //
  // @observable
  // ObservableFuture<ContactUsModel> contactUsFuture;
  //
  // //* COMPUTED *//
  //
  @computed
  AboutUsModel get aboutUs => aboutUsFuture?.value;

  @computed
  bool get aboutUsLoading => aboutUsFuture?.isPending ?? false;

  @computed
  ContactUsModel get contacts => contactsFuture?.value;

  @computed
  bool get contactsLoading => contactsFuture?.isPending ?? false;

  @computed
  ContactUsModel get gallery => contactsFuture?.value;

  @computed
  bool get galleryLoading => contactsFuture?.isPending ?? false;

  @computed
  ContactUsModel get partners => contactsFuture?.value;

  @computed
  bool get partnersLoading => contactsFuture?.isPending ?? false;

  @computed
  ContactUsModel get downloads => contactsFuture?.value;

  @computed
  bool get downloadsLoading => contactsFuture?.isPending ?? false;

  @computed
  bool get isLogged => isLoggedIn;

  //
  // @computed
  // ContactUsModel get contactUs => contactUsFuture?.value;
  //
  // //* ACTIONS *//
  //

  @action
  void userLoggedIn() {
    if (prefsRepository.user == null) {
      getContext((context) {
        tabs.add(Text(context.translate('lbl_log_in')));
        tabs.add(Text(context.translate('lbl_about_us')));
        tabs.add(Text(context.translate('lbl_gallery')));
        tabs.add(Text(context.translate('lbl_contacts')));
        tabs.add(Text(context.translate('lbl_strategic_partners')));
        tabs.add(Text(context.translate('lbl_download_center')));
      });
      isLoggedIn = !isLoggedIn;
      pages.insert(0, const LoginPage());
    } else {
      getContext((context) {
        tabs.add(Text(context.translate('lbl_about_us')));
        tabs.add(Text(context.translate('lbl_gallery')));
        tabs.add(Text(context.translate('lbl_contacts')));
        tabs.add(Text(context.translate('lbl_strategic_partners')));
        tabs.add(Text(context.translate('lbl_download_center')));
      });
    }
  }

  @action
  void getaboutUs() => aboutUsFuture = futureWrapper(
        () => _publicinfoRepository
            .getAboutUs()
            .whenSuccess((res) => res.data.first),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getcontactUs() => contactsFuture = futureWrapper(
        () => _publicinfoRepository
            .getContactUs()
            .whenSuccess((res) => res.data.first),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );
}
