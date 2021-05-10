import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/pagination_mixin.dart';
import 'package:core_sdk/utils/search_mixin.dart';
import 'package:core_sdk/utils/widgets/pagination_list.dart';
import 'package:core_sdk/utils/widgets/unfucus_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/user_list_tile.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/data/models/player_filter_model.dart';
import 'package:mawaheb_app/features/players/ui/pages/view_player_profile.dart';
import 'package:mawaheb_app/features/players/ui/widgets/filter_chip_widget.dart';
import 'package:mawaheb_app/features/players/ui/widgets/player_filter_widget.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key? key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const PlayersPage());

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends MobxState<PlayersPage, PlayersViewmodel> with SearchMixin, PaginationMixin {
  @override
  void initState() {
    super.initState();
    initSearch();
    initPagination();
  }

  @override
  void dispose() {
    disposeSearch();
    disposePagination();
    super.dispose();
  }

  PlayerFilterModel? get filter => viewmodel.filter;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> test = {
      'RIGHT': context.translate('lbl_right'),
      'LEFT': context.translate('lbl_left'),
      'BOTH': context.translate('lbl_both'),
    };

    return Observer(builder: (_) {
      return Scaffold(
        key: viewmodel.scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: LIGHT_GREY, width: 0.5),
                  color: WHITE,
                  boxShadow: const [BoxShadow(blurRadius: 6, offset: Offset(0, 3), color: LIGHT_GREY)],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          hintStyle: context.textTheme.bodyText1!.copyWith(color: Colors.grey),
                          hintText: context.translate('lbl_search_name'),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(context.fullWidth * 0.03),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => PlayerFilterWidget.show(
                        context,
                        viewmodel: viewmodel,
                        query: searchController!.text,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/icons/ic_filter.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Observer(builder: (_) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    if (viewmodel.filter?.sport != null)
                      filterChip(
                        context: context,
                        text: viewmodel.filter!.sport!.name!,
                        onRemove: () {
                          viewmodel.filter = PlayerFilterModel(
                            country: filter?.country,
                            sport: null,
                            position: filter?.position,
                            hand: filter?.hand,
                            leg: filter?.leg,
                            name: filter?.name,
                            partnerId: filter?.partnerId,
                            isConfirmed: filter?.isConfirmed,
                            isBooked: filter?.isBooked,
                          );
                          viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                        },
                      ),
                    if (viewmodel.filter?.country != null)
                      filterChip(
                        context: context,
                        text: viewmodel.filter!.country!.name!,
                        onRemove: () {
                          viewmodel.filter = PlayerFilterModel(
                            country: null,
                            sport: filter?.sport,
                            position: filter?.position,
                            hand: filter?.hand,
                            leg: filter?.leg,
                            name: filter?.name,
                            partnerId: filter?.partnerId,
                            isConfirmed: filter?.isConfirmed,
                            isBooked: filter?.isBooked,
                          );
                          viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                        },
                      ),
                    if (viewmodel.filter?.position != null)
                      filterChip(
                        context: context,
                        text: viewmodel.filter!.position!.name!,
                        onRemove: () {
                          viewmodel.filter = PlayerFilterModel(
                            country: filter?.country,
                            sport: filter?.sport,
                            position: null,
                            hand: filter?.hand,
                            leg: filter?.leg,
                            name: filter?.name,
                            partnerId: filter?.partnerId,
                            isConfirmed: filter?.isConfirmed,
                            isBooked: filter?.isBooked,
                          );
                          viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                        },
                      ),
                    if (viewmodel.filter?.hand != null)
                      // TODO(ahmad): add localization to hand string
                      filterChip(
                        context: context,
                        text: test[viewmodel.filter!.hand!]! + context.translate('lbl_hand'),
                        onRemove: () {
                          viewmodel.filter = PlayerFilterModel(
                            country: filter?.country,
                            sport: filter?.sport,
                            position: filter?.position,
                            hand: null,
                            leg: filter?.leg,
                            name: filter?.name,
                            partnerId: filter?.partnerId,
                            isConfirmed: filter?.isConfirmed,
                            isBooked: filter?.isBooked,
                          );
                          viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                        },
                      ),
                    if (viewmodel.filter?.leg != null)
                      // TODO(ahmad): add localization to leg string

                      filterChip(
                        context: context,
                        text: test[viewmodel.filter!.hand!]! + context.translate('lbl_leg'),
                        onRemove: () {
                          viewmodel.filter = PlayerFilterModel(
                            country: filter?.country,
                            sport: filter?.sport,
                            position: filter?.position,
                            hand: filter?.hand,
                            leg: null,
                            name: filter?.name,
                            partnerId: filter?.partnerId,
                            isConfirmed: filter?.isConfirmed,
                            isBooked: filter?.isBooked,
                          );
                          viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                        },
                      ),
                  ],
                );
              }),
            ),
            Expanded(
              child: Observer(builder: (_) {
                return RefreshIndicator(
                  onRefresh: () async {
                    searchController!.text = '';
                    viewmodel.searchPlayers(fresh: true, query: searchController!.text);
                  },
                  child: MawahebFutureBuilder<ListBaseResponseModel<PlayerModel>>(
                      future: viewmodel.playersFuture,
                      onRetry: () => viewmodel.searchPlayers(fresh: true, query: searchController!.text),
                      onSuccess: (ListBaseResponseModel<PlayerModel>? players) {
                        return FocusDetector(
                          child: PaginationList<PlayerModel>(
                              canLoadMore: viewmodel.canLoadMorePlayers,
                              dataList: players!.data!,
                              scrollController: scrollController,
                              shrinkWrap: false,
                              padding: 0,
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              emptyWidget: Center(child: Text(context.translate('msg_no_match_players'))),
                              cardBuilder: (player) {
                                return heroUserListTile(
                                  context,
                                  name: player.name!,
                                  id: player.id,
                                  photoId: player.photoId,
                                  token: viewmodel.prefsRepository.token,
                                  onTap: () =>
                                      App.navKey.currentState!.push(ViewPlayerProfile.pageRoute(viewmodel, player)),
                                );
                              }),
                        );
                      }),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  @override
  void onLoadMore() => viewmodel.searchPlayers(query: searchController!.text);

  @override
  void onSearch(String qurey) => viewmodel.searchPlayers(query: qurey, fresh: true);
}
