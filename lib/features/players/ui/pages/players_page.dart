import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/user_list_tile.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/players/ui/pages/view_player_profile.dart';
import 'package:mawaheb_app/features/players/ui/widgets/filter_chip_widget.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/settings/ui/widgets/switch_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const PlayersPage());

  // static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends MobxState<PlayersPage, PlayersViewmodel> {
  TextEditingController nameController = TextEditingController();
  SportModel currentSport;
  SportPositionModel position;
  CountryModel currentCountry;
  String hand;
  String leg;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.players == null) {
      viewmodel.searchPlayers();
    }

    if (viewmodel?.sports == null) {
      viewmodel.getSports();
    }
    if (viewmodel?.positions == null) {
      viewmodel.getPositions();
    }
    if (viewmodel?.countries == null) {
      viewmodel.getCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 10,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            viewmodel.sport = null;
                            viewmodel.country = null;
                            viewmodel.position = null;
                            viewmodel.leg = null;
                            viewmodel.hand = null;
                            currentSport = null;
                            currentCountry = null;
                            hand = null;
                            leg = null;
                            position = null;
                            filterBottomSheet();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/ic_filter.svg',
                            ),
                          ),
                        ),
                        hintStyle: context.textTheme.bodyText1
                            .copyWith(color: Colors.grey),
                        hintText: context.translate('lbl_search_name'),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.all(context.fullWidth * 0.03),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.fullHeight * 0.01,
                    horizontal: context.fullWidth * 0.05),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    if (viewmodel.sport != null)
                      filterChip(context: context, text: viewmodel.sport.name),
                    if (viewmodel.country != null)
                      filterChip(
                          context: context, text: viewmodel.country.name),
                    if (viewmodel.position != null)
                      filterChip(
                          context: context, text: viewmodel.position.name),
                    if (viewmodel.hand != null)
                      filterChip(context: context, text: viewmodel.hand),
                    if (viewmodel.leg != null)
                      filterChip(context: context, text: viewmodel.leg),
                  ],
                ),
              ),
              if (viewmodel.players != null)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewmodel.players.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          viewmodel.playerName = viewmodel.players[index].name;

                          viewmodel.viewProfilePlayer(
                              id: viewmodel.players[index].id);

                          viewmodel.playerId = viewmodel.players[index].id;

                          App.navKey.currentState
                              .push(ViewPlayerProfile.pageRoute(viewmodel));
                        },
                        child: userListTile(
                            name: viewmodel.players[index].name,
                            photo: viewmodel.players[index].photo,
                            token: viewmodel.prefsRepository.token),
                      );
                    }),
              if (viewmodel.players == null)
                Center(
                    child: Text(context.translate('msg_no_match_players'),
                        style: textTheme.headline2.copyWith(fontSize: 20)))
            ],
          ),
        ),
      );
    });
  }

  void filterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Wrap(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 43),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.translate('lbl_filter'),
                          style: context.textTheme.headline2.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      mawhaebDropDown(
                        hint: 'lbl_nationality',
                        context: context,
                        onChanged: (value) {
                          currentCountry = value;
                        },
                        items: viewmodel.countries
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.name),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                        hint: context.translate('lbl_sport_name'),
                        context: context,
                        onChanged: (value) {
                          currentSport = value;
                        },
                        items: viewmodel.sports
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.name),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                        hint: context.translate('lbl_position'),
                        context: context,
                        onChanged: (value) {
                          position = value;
                        },
                        items: viewmodel.positions
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.name),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          hint: context.translate('lbl_prefer_hand'),
                          context: context,
                          items: ['RIGHT', 'LEFT', 'BOTH']
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            hand = v;
                          }),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          hint: context.translate('lbl_prefer_leg'),
                          context: context,
                          items: ['RIGHT', 'LEFT', 'BOTH']
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            print(v);
                            print(leg);
                            leg = v;
                          }),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate('lbl_confirmed_by_us'),
                              style: textTheme.subtitle1.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Observer(
                            builder: (_) {
                              return mawahebSwitchButton(
                                isSelected: viewmodel.confirmed,
                                onChanged: (value) {
                                  viewmodel.confirmed = value;
                                },
                              );
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate('lbl_booked_by_us'),
                              style: textTheme.subtitle1.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Observer(
                            builder: (_) {
                              return mawahebSwitchButton(
                                isSelected: viewmodel.booked,
                                onChanged: (value) {
                                  viewmodel.booked = value;
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 26),
                      MawahebButton(
                        context: context,
                        buttonColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        text: 'lbl_filter',
                        onPressed: () {
                          print(viewmodel.booked);
                          // viewmodel.searchPlayers(
                          //     country: currentCountry?.name ?? '',
                          //     sport: currentSport?.name ?? '',
                          //     position: position?.name ?? '',
                          //     hand: hand ?? '',
                          //     name: nameController.text ?? '',
                          //     leg: leg ?? '');
                          // viewmodel.sport = currentSport;
                          // viewmodel.country = currentCountry;
                          // viewmodel.position = position;
                          // viewmodel.leg = leg;
                          // viewmodel.hand = hand;
                          // context.pop();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}
