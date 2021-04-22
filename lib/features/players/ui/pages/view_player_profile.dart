import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/features/profile/ui/pages/videos_page.dart';
import '../../../profile/ui/pages/my_info_page.dart';

class ViewPlayerProfile extends StatefulWidget {
  const ViewPlayerProfile({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute pageRoute(PlayersViewmodel playersViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: playersViewmodel,
          child: const ViewPlayerProfile(),
        ),
      );

  @override
  _ViewPlayerProfileState createState() => _ViewPlayerProfileState();
}

class _ViewPlayerProfileState
    extends ProviderMobxState<ViewPlayerProfile, PlayersViewmodel>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    viewmodel.fetchPlayer(id: viewmodel.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: customAppBar(context: context, withTitle: false),
        backgroundColor: Colors.white,
        body: viewmodel.player == null
            ? const Center(child: MawahebLoader())
            : Column(
                children: [
                  profileDetails(context: context, name: viewmodel.playerName),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: context.fullHeight * 0.07,
                    decoration: BoxDecoration(
                      color: GREY,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: YELLOW,
                      ),
                      tabs: [
                        Text(
                          context.translate('lbl_personal_info'),
                        ),
                        Text(
                          context.translate('lbl_videos'),
                        ),
                      ],
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.black,
                      labelStyle: context.textTheme.bodyText1,
                      // labelPadding:
                      //     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      controller: _tabController,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      const MyInfoPage(),
                      const VideosPage(),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                      bottom: 33,
                      right: 38,
                      left: 38,
                    ),
                    height: context.fullHeight * 0.08,
                    color: Colors.white,
                    child: viewmodel.player.availability == 'BOOKED'
                        ? MawahebGradientButton(
                            context: context,
                            text: 'lbl_confirm_player',
                            onPressed: () {})
                        : MawahebGradientButton(
                            context: context,
                            text: 'lbl_book_player',
                            onPressed: () {
                              viewmodel.bookPlayer(
                                  playerId: viewmodel.player.id);
                            }),
                  )
                ],
              ),
      );
    });
  }
}
