import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';
import 'package:provider/provider.dart';

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
    if (viewmodel?.isLoggedIn != null) {
      viewmodel.userLoggedIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: viewmodel.pages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            shape: const Border(bottom: BorderSide(color: GREY)),
            bottom: TabBar(
              labelPadding:
                  const EdgeInsets.only(bottom: 10, right: 20, left: 20),
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: GREY,
              unselectedLabelStyle: textTheme.headline2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3),
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
              tabs: viewmodel.tabs,
            ),
          ),
        ),
        body: Provider(
          create: (_) => viewmodel,
          child: TabBarView(
            children: viewmodel.pages,
            physics: const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
