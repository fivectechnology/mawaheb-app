import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/players/ui/pages/personal_info_page.dart';
import 'package:mawaheb_app/features/players/ui/pages/video_player_page.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
                  profileDetails(
                      context: context,
                      name: viewmodel.playerName,
                      photo: viewmodel.player.photo,
                      token: viewmodel.prefsRepository.token,
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isConfirmed: viewmodel.player.availability == 'CONFIRMED'
                          ? true
                          : false),
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
                    child:
                        TabBarView(controller: _tabController, children: const [
                      PersonalInfoPage(),
                      VideoPlayerPage(),
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
                      child: Column(
                        children: [
                          if (viewmodel.player.availability == 'BOOKED')
                            MawahebGradientButton(
                                context: context,
                                text: 'lbl_confirm_player',
                                isLoading: viewmodel.confirmPlayerLoading,
                                onPressed: () {
                                  viewmodel.confirmPlayer();
                                  _confirmationBottomSheet(
                                      context: context, state: 'confirmed');
                                }),
                          if (viewmodel.player.availability == 'CONFIRMED')
                            MawahebGradientButton(
                                context: context,
                                text: 'lbl_released_player',
                                isLoading: viewmodel.releasePlayerLoading,
                                onPressed: () {
                                  viewmodel.releasePlayer();
                                  _confirmationBottomSheet(
                                      context: context, state: 'released');
                                }),
                          if (viewmodel.player.availability == 'RELEASED')
                            MawahebGradientButton(
                                context: context,
                                text: 'lbl_book_player',
                                isLoading: viewmodel.bookPlayerLoading,
                                onPressed: () {
                                  viewmodel.bookPlayer(
                                      playerId: viewmodel.player.id);
                                  _confirmationBottomSheet(
                                      context: context, state: 'booked');
                                }),
                        ],
                      ))
                ],
              ),
      );
    });
  }

  void _confirmationBottomSheet({BuildContext context, String state}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Wrap(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/confirm.svg'),
                    SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate('msg_player_$state'),
                        style: textTheme.headline2
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 34,
                  ),
                  child: MawahebButton(
                    context: context,
                    text: 'lbl_back',
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
