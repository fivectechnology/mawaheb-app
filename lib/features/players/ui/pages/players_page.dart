import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/user_list_tile.dart';
import 'package:mawaheb_app/features/players/ui/widgets/filter_chip_widget.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/settings/ui/widgets/switch_button.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const PlayersPage());

  // static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends MobxState<PlayersPage, PlayersViewmodel> {
  bool noti = false;
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
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          filterBottomSheet();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/ic_filter.svg',
                          ),
                        ),
                      ),
                      hintStyle: context.textTheme.bodyText1.copyWith(color: Colors.grey),
                      hintText: 'Search by name',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(context.fullWidth * 0.03),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01, horizontal: context.fullWidth * 0.05),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  filterChip(context: context, text: 'football'),
                ],
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return userListTile();
                })
          ],
        ),
      ),
    );
  }

  void filterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 43),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(context.translate('lbl_filter'),
                          style: context.textTheme.headline2.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      mawhaebDropDown(
                          textColor: Colors.black, hint: context.translate('lbl_nationality'), context: context),
                      const SizedBox(height: 26),
                      mawhaebDropDown(textColor: Colors.black, hint: context.translate('lbl_sport'), context: context),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          textColor: Colors.black, hint: context.translate('lbl_position'), context: context),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          textColor: Colors.black, hint: context.translate('lbl_prefer_hand'), context: context),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          textColor: Colors.black, hint: context.translate('lbl_prefer_hand'), context: context),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate('lbl_confirmed_by_us'),
                              style: textTheme.subtitle1.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                          const NotificationButton(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate('lbl_booked_by_us'),
                              style: textTheme.subtitle1.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                          const NotificationButton()
                        ],
                      ),
                      const SizedBox(height: 26),
                      MawahebButton(
                        context: context,
                        buttonColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        text: 'lbl_filter',
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}
