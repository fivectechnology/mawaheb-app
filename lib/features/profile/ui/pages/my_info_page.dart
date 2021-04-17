import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/card_info_player.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/player_info_page.dart';
import 'package:mawaheb_app/features/profile/ui/pages/edits/edit_address_page.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:provider/provider.dart';
import '../../../auth/register/ui/pages/add_sport_page.dart';

import '../../../auth/register/ui/pages/address_info_page.dart';
import 'edits/edit_personal_page.dart';
import 'edits/edit_sport_page.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const MyInfoPage());

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends ProviderMobxState<MyInfoPage, ProfileViewmodel> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.player == null) {
      viewmodel.fetchPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder<PlayerModel>(
      future: viewmodel.playerFuture,
      onRetry: viewmodel.fetchPlayer,
      onSuccess: (player) {
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
                      onPressed: () => context.navigator.push(EditSportPage.pageRoute(viewmodel)),
                    ),
                    // Provider(
                    //   create: (_) => viewmodel,
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.edit,
                    //       color: DARK_GREY,
                    //     ),
                    //     onPressed: () => context.pushPage(const EditSportPage()),
                    //   ),
                    // )
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(title: 'lbl_sport_name', value: viewmodel.player.sport?.name ?? 'N/A', context: context),
                infoRow(title: 'lbl_position', value: viewmodel.player.position?.name ?? 'N/A', context: context),
                infoRow(title: 'lbl_weight', value: viewmodel.player.weight, context: context),
                infoRow(title: 'lbl_hight', value: viewmodel.player.height, context: context),
                infoRow(title: 'lbl_prefer_hand', value: viewmodel.player.hand, context: context),
                infoRow(title: 'lbl_prefer_leg', value: viewmodel.player.leg, context: context),
                infoRow(title: 'lbl_brief', value: viewmodel.player.brief, context: context),
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
                      onPressed: () => context.pushPage(const EditPersonalPage()),
                    )
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(title: 'lbl_full_name', value: viewmodel.player.name, context: context),
                infoRow(title: 'lbl_date_of_birth', value: viewmodel.player.dateOfBirth, context: context),
                infoRow(title: 'lbl_phone_num', value: viewmodel.player.phone, context: context),
                infoRow(title: 'lbl_nationality', value: viewmodel.player.country.name, context: context),
                infoRow(title: 'lbl_category', value: viewmodel.player.category.title, context: context),
                infoRow(title: 'lbl_gender', value: viewmodel.player.gender, context: context),
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
                      onPressed: () => context.pushPage(const EditAddressPage()),
                    )
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(title: 'lbl_country', value: viewmodel.player.country?.name ?? 'N/A', context: context),
                infoRow(title: 'lbl_state/province/area', value: viewmodel.player.area, context: context),
                infoRow(title: 'lbl_address', value: viewmodel.player.address, context: context),
              ]),
              SizedBox(height: context.fullHeight * 0.04),
            ],
          ),
        );
      },
    );
  }
}
