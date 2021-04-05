import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'file:///E:/Android%20Projects/mawaheb-app/lib/features/home/ui/pages/renew_subscription_page.dart';
import 'file:///E:/Android%20Projects/mawaheb-app/lib/features/players/ui/pages/videos_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/view_page.dart';
import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'my_info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const ProfilePage());

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends MobxState<ProfilePage, ProfileViewmodel>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: context.fullHeight * 0.01),
        child: Column(
          children: [
            profileActivationRow(isPending: true),
            profileDetails(context: context),
            Container(
              margin: EdgeInsets.only(top: context.fullHeight * 0.02),
              height: context.fullHeight * 0.07,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]))),
              child: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(width: 3.0, color: RED),
                    insets: EdgeInsets.symmetric(
                        horizontal: context.fullWidth * 0.08)),
                tabs: [
                  Text(
                    'my info',
                    style: textTheme.headline2
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Videos',
                    style: textTheme.headline2
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Views',
                    style: textTheme.headline2
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                labelStyle: textTheme.subtitle1,
                labelPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                MyInfoPage(),
                VideosPage(),
                ViewsPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget profileActivationRow({bool isPending}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.04),
      height: context.fullHeight * 0.08,
      color: Colors.grey[300],
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/ic_otp.svg',
            height: 20,
            color: isPending ? RED : null,
          ),
          const SizedBox(
            width: 10,
          ),
          if (!isPending)
            Text(
              'Profile Active till march 3, 2022',
              style: textTheme.subtitle1,
            )
          else
            Text(
              'Profile pending, payment required',
              style: textTheme.subtitle1,
            ),
          Visibility(
              visible: isPending,
              child: IconButton(
                onPressed: () {
                  App.navKey.currentState.push(RenewSubscriptionPage.pageRoute);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ))
        ],
      ),
    );
  }
}
