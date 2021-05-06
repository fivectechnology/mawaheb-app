import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/auth/login/ui/pages/login_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/strategic_partners_page.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';
import 'package:provider/provider.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'about_us_page.dart';
import 'contacts_page.dart';
import 'download_center_page.dart';
import 'gallery_page.dart';

class PublicInfoPage extends StatefulWidget {
  const PublicInfoPage({Key key}) : super(key: key);

  static const String route = '/public_info';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const PublicInfoPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _PublicInfoPageState createState() => _PublicInfoPageState();
}

class _PublicInfoPageState
    extends MobxState<PublicInfoPage, PublicInfoViewmodel> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: viewmodel.prefsRepository.user == null ? 6 : 5,
      child: Scaffold(
        backgroundColor: WHITE,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            shape: const Border(bottom: BorderSide(color: GREY)),
            bottom: TabBar(
              labelPadding: const EdgeInsets.only(
                bottom: 10,
                right: 20,
                left: 20,
              ),
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: GREY,
              unselectedLabelStyle: textTheme.headline2.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
              indicatorColor: RED,
              labelColor: Colors.black,
              labelStyle: textTheme.headline2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3),
              indicatorWeight: 3,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: RED),
                  insets: EdgeInsets.symmetric(horizontal: 15)),
              tabs: [
                if (viewmodel.prefsRepository.user == null)
                  Text(context.translate('lbl_log_in')),
                Text(context.translate('lbl_about_us')),
                Text(context.translate('lbl_gallery')),
                Text(context.translate('lbl_contacts')),
                Text(context.translate('lbl_strategic_partners')),
                Text(context.translate('lbl_download_center')),
              ],
            ),
          ),
        ),
        body: Provider(
          create: (_) => viewmodel,
          child: TabBarView(
            children: [
              if (viewmodel.prefsRepository.user == null) const LoginPage(),
              const AboutUsPage(),
              const GalleryPage(),
              const ContactsPage(),
              const StrategicPartnersPage(),
              const DownLoadCenterPage()
            ],
            physics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
