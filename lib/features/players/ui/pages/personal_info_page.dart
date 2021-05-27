import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/card_info_player.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';

import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const PersonalInfoPage());

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState
    extends ProviderMobxState<PersonalInfoPage, PlayersViewmodel> {
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
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder<PlayerModel>(
      future: viewmodel?.playerFuture,
      onRetry: viewmodel?.fetchPlayer ?? () {},
      onSuccess: (player) {
        return Scaffold(
          backgroundColor: WHITE,
          body: ListView(
            physics: const BouncingScrollPhysics(),
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
                      child: Text(context.translate('lbl_info_sport'),
                          style: context.textTheme.subtitle1!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(
                  title: 'lbl_sport_name',
                  value: player?.sport?.tName ?? player?.sport?.name ?? 'N/A',
                  context: context,
                ),
                infoRow(
                  title: 'lbl_position',
                  value: player?.position?.tName ??
                      player?.position?.name ??
                      'N/A',
                  context: context,
                ),
                infoRow(
                    title: 'lbl_weight',
                    value: player?.weight,
                    context: context),
                infoRow(
                    title: 'lbl_hight',
                    value: player?.height,
                    context: context),
                infoRow(
                    title: 'lbl_prefer_hand',
                    value: player?.hand,
                    context: context),
                infoRow(
                    title: 'lbl_prefer_leg',
                    value: player?.leg,
                    context: context),
                infoRow(
                    title: 'lbl_brief', value: player?.brief, context: context),
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
                          style: context.textTheme.subtitle1!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(
                    title: 'lbl_full_name',
                    value: player?.name,
                    context: context),
                infoRow(
                    title: 'lbl_date_of_birth',
                    value: player?.dateOfBirth,
                    context: context),
                infoRow(
                    title: 'lbl_phone_num',
                    value: player?.phone,
                    context: context),
                infoRow(
                  title: 'lbl_nationality',
                  value:
                      player?.country?.tName ?? player?.country?.name ?? 'N/A',
                  context: context,
                ),
                infoRow(
                    title: 'lbl_category',
                    value: player?.category?.title ?? 'N/A',
                    context: context),
                infoRow(
                    title: 'lbl_gender',
                    value: player?.gender,
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
                      child: Text(context.translate('lbl_address'),
                          style: context.textTheme.subtitle1!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              cardInfoPlayer(context: context, rows: [
                infoRow(
                  title: 'lbl_emirate',
                  value:
                      player?.emirate?.tName ?? player?.emirate?.name ?? 'N/A',
                  context: context,
                ),
                infoRow(
                    title: 'lbl_state/province/area',
                    value: player?.area,
                    context: context),
                infoRow(
                    title: 'lbl_address',
                    value: player?.address,
                    context: context),
              ]),
              SizedBox(height: context.fullHeight * 0.04),
            ],
          ),
        );
      },
    );
  }
}
