import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/home/ui/pages/renew_subscription_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/features/profile/ui/pages/my_info_page.dart';

import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const ProfilePage());

  // static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.player == null) {
      viewmodel.fetchPlayer(id: viewmodel.prefsRepository.player.id);
    }
    viewmodel.pages[0] = MyInfoPage(id: viewmodel.prefsRepository.player.id);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SafeArea(
        child: viewmodel.player == null
            ? const Center(child: MawahebLoader())
            : Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    profileActivationRow(isPending: true),
                    profileDetails(
                        context: context, name: viewmodel.player.name),
                    Container(
                      height: context.fullHeight * 0.07,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1.0, color: GREY))),
                      child: TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide:
                                const BorderSide(width: 3.0, color: RED),
                            insets: EdgeInsets.symmetric(
                                horizontal: context.fullWidth * 0.1)),
                        tabs: [
                          Text(
                            'my info',
                            style: textTheme.headline2.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Videos',
                            style: textTheme.headline2.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Views',
                            style: textTheme.headline2.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                        unselectedLabelColor: GREY,
                        labelColor: Colors.black,
                        labelStyle: textTheme.subtitle1,
                        controller: _tabController,
                      ),
                    ),
                    Expanded(
                      child: Provider(
                        create: (_) => viewmodel,
                        child: TabBarView(
                            controller: _tabController,
                            children: viewmodel.pages),
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  Widget profileActivationRow({bool isPending}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.04),
      height: context.fullHeight * 0.08,
      color: GREY.withOpacity(0.5),
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
                  color: DARK_GREY.withOpacity(0.6),
                  size: 16,
                ),
              ))
        ],
      ),
    );
  }
}
