import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/about_us_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/contacts_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/download_center_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/gallery_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/strategic_partners_page.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class PublicInfoPage extends StatefulWidget {
  const PublicInfoPage({Key key}) : super(key: key);

  static const String route = '/public_info';

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const PublicInfoPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _PublicInfoPageState createState() => _PublicInfoPageState();
}

class _PublicInfoPageState extends MobxState<PublicInfoPage, PublicInfoViewmodel> {
  TabController _tabController;

  List<Widget> pages = const [
    AboutUsPage(),
    GalleryPage(),
    ContactsPage(),
    StrategicPartnersPage(),
    DownLoadCenterPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      Text(context.translate('lbl_about_us')),
      Text(context.translate('lbl_gallery')),
      Text(context.translate('lbl_contacts')),
      Text(context.translate('lbl_strategic_partners')),
      Text(context.translate('lbl_download_center'))
    ];
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            shape: Border(bottom: BorderSide(color: Colors.grey[400])),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              indicatorColor: RED,
              labelColor: Colors.black,
              labelStyle: textTheme.subtitle1,
              indicatorWeight: 3,
              labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              tabs: _tabs,
            ),
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
