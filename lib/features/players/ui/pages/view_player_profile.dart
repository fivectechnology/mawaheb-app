import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_dialog.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/ui/pages/personal_info_page.dart';
import 'package:mawaheb_app/features/players/ui/pages/video_player_page.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ViewPlayerProfile extends StatefulWidget {
  const ViewPlayerProfile({
    Key? key,
    required this.player,
  }) : super(key: key);

  final PlayerModel player;

  static MaterialPageRoute pageRoute(PlayersViewmodel playersViewmodel, PlayerModel player) {
    return MaterialPageRoute(
      builder: (context) => Provider.value(
        value: playersViewmodel
          ..viewProfilePlayer(id: player.id)
          ..fetchPlayer(id: player.id)
          ..fetchVideos(playerId: player.id),
        child: ViewPlayerProfile(player: player),
      ),
    );
  }

  @override
  _ViewPlayerProfileState createState() => _ViewPlayerProfileState();
}

class _ViewPlayerProfileState extends ProviderMobxState<ViewPlayerProfile, PlayersViewmodel>
    with TickerProviderStateMixin {
  TabController? _tabController;

  PlayerModel get player => widget.player;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String? get availability => (viewmodel.player ?? player).availability;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, withTitle: false) as PreferredSizeWidget?,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Observer(
            builder: (_) {
              return heroProfileDetails(
                context: context,
                name: player.name!,
                id: player.id,
                photoId: player.photoId,
                token: viewmodel.prefsRepository.token,
                isConfirmed: availability == 'CONFIRMED',
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: context.fullHeight * 0.07,
            decoration: BoxDecoration(
              color: GREY,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: TabBar(
              indicator: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: YELLOW),
              tabs: [
                Text(context.translate('lbl_personal_info')),
                Text(context.translate('lbl_videos')),
              ],
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: context.textTheme.bodyText1,
              controller: _tabController,
            ),
          ),
          const SizedBox(height: 26),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              PersonalInfoPage(),
              VideoPlayerPage(),
            ]),
          ),
          Observer(
            builder: (_) {
              final Tuple3 buttonParams = getButtonParams(context, availability);
              return Container(
                margin: const EdgeInsets.only(top: 15, bottom: 33, right: 38, left: 38),
                child: MawahebGradientButton(
                  context: context,
                  text: buttonParams.item1,
                  isLoading: viewmodel.statusButtonLoading,
                  onPressed: () async {
                    await mawahebShowConfirmDialog(
                      context: context,
                      message: context.translate(buttonParams.item2),
                      onConfirm: buttonParams.item3,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Tuple3<String?, String?, VoidCallback?> getButtonParams(BuildContext context, String? availability) {
    String? title;
    String? message;
    VoidCallback? onConfirm;
    switch (availability) {
      case 'BOOKED':
        title = 'lbl_confirm_player';
        message = 'msg_confirm_player';
        onConfirm = viewmodel.confirmPlayer;
        break;
      case 'CONFIRMED':
        title = 'lbl_released_player';
        message = 'msg_release_player';
        onConfirm = viewmodel.releasePlayer;
        break;
      case 'RELEASED':
        title = 'lbl_book_player';
        message = 'msg_book_player';
        onConfirm = viewmodel.bookPlayer;
        break;
    }
    return Tuple3(title, message, onConfirm);
  }
}
