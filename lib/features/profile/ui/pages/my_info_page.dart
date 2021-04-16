import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/card_info_player.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/player_info_page.dart';
import '../../../auth/register/ui/pages/add_sport_page.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import '../../../auth/register/ui/pages/address_info_page.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  bool isPlayer = true;
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
      backgroundColor: WHITE,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26, bottom: 12),
                  child: Text(context.translate('Sport'),
                      style: context.textTheme.subtitle1.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: DARK_GREY,
                    ),
                    onPressed: () {
                      App.navKey.currentState.push(AddSportPage.pageRoute);
                    })
              ],
            ),
          ),
          cardInfoPlayer(context: context, rows: [
            infoRow(title: 'lbl_sport_name', value: 'Football', context: context),
            infoRow(title: 'lbl_position', value: 'Football', context: context),
            infoRow(title: 'lbl_weight', value: 'Football', context: context),
            infoRow(title: 'lbl_hight', value: 'Football', context: context),
            infoRow(title: 'lbl_prefer_hand', value: 'Football', context: context),
            infoRow(title: 'lbl_prefer_leg', value: 'Football', context: context),
            infoRow(
                title: 'lbl_brief',
                value: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis risus mi. Ut ….',
                context: context),
          ]),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(context.translate('lbl_personal_info'),
                      style: context.textTheme.subtitle1.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: DARK_GREY,
                    ),
                    onPressed: () {
                      App.navKey.currentState.push(PlayerInfoPage.pageRoute);
                    })
              ],
            ),
          ),
          cardInfoPlayer(context: context, rows: [
            infoRow(title: 'lbl_full_name', value: 'Football', context: context),
            infoRow(title: 'lbl_date_of_birth', value: 'Football', context: context),
            infoRow(title: 'lbl_phone_num', value: 'Football', context: context),
            infoRow(title: 'lbl_nationality', value: 'Football', context: context),
            infoRow(title: 'lbl_category', value: 'Football', context: context),
            infoRow(title: 'lbl_gender', value: 'Football', context: context),
          ]),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(context.translate('lbl_address'),
                      style: context.textTheme.subtitle1.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: DARK_GREY,
                    ),
                    onPressed: () {
                      App.navKey.currentState.push(AddressInfoPage.pageRoute);
                    })
              ],
            ),
          ),
          cardInfoPlayer(context: context, rows: [
            infoRow(title: 'lbl_country', value: 'Football', context: context),
            infoRow(title: 'lbl_state/province/area', value: 'Football', context: context),
            infoRow(title: 'lbl_address', value: 'Football', context: context),
          ]),
          SizedBox(height: context.fullHeight * 0.04),
        ],
      ),
    );
  }
}
