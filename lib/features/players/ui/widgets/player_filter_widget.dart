import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/players/data/models/player_filter_model.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:mawaheb_app/features/settings/ui/widgets/switch_button.dart';

class PlayerFilterWidget extends StatefulWidget {
  const PlayerFilterWidget({
    Key key,
    @required this.viewmodel,
    @required this.query,
  }) : super(key: key);
  final PlayersViewmodel viewmodel;
  final String query;

  @override
  _PlayerFilterWidgetState createState() => _PlayerFilterWidgetState();

  static Future show(
    BuildContext context, {
    @required PlayersViewmodel viewmodel,
    @required String query,
  }) =>
      showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (_) => PlayerFilterWidget(
          query: query,
          viewmodel: viewmodel,
        ),
      );
}

class _PlayerFilterWidgetState extends State<PlayerFilterWidget> {
  PlayerFilterModel filter;

  @override
  void initState() {
    super.initState();
    filter = widget.viewmodel.filter;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> test = {
      'RIGHT': context.translate('lbl_right'),
      'LEFT': context.translate('lbl_left'),
      'BOTH': context.translate('lbl_both'),
    };

    final textTheme = context.textTheme;
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.translate('lbl_filter'),
                style: context.textTheme.headline2
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              mawhaebDropDown(
                hint: 'lbl_nationality',
                value: filter?.country,
                context: context,
                onChanged: (value) => changePlayerFilter(country: value),
                items: widget.viewmodel.countries
                    .map((em) => DropdownMenuItem(
                          child: Text(em.tName ?? em.name),
                          value: em,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 26),
              mawhaebDropDown(
                hint: context.translate('lbl_sport_name'),
                context: context,
                value: filter?.sport,
                onChanged: (value) => changePlayerFilter(sport: value),
                items: widget.viewmodel.sports
                    .map((em) => DropdownMenuItem(
                          child: Text(em.tName ?? em.name),
                          value: em,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 26),
              mawhaebDropDown(
                hint: context.translate('lbl_position'),
                context: context,
                value: filter?.position,
                onChanged: (value) => changePlayerFilter(position: value),
                items: widget.viewmodel.positions
                    .map((em) => DropdownMenuItem(
                          child: Text(em.tName ?? em.name),
                          value: em,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 26),
              mawhaebDropDown(
                hint: context.translate('lbl_prefer_hand'),
                context: context,
                value: filter?.hand,
                items: test
                    .map((key, value) {
                      return MapEntry(
                          key,
                          DropdownMenuItem(
                            value: key,
                            child: Text(value),
                          ));
                    })
                    .values
                    .toList(),
                onChanged: (value) => changePlayerFilter(hand: value),
              ),
              const SizedBox(height: 26),
              mawhaebDropDown(
                hint: context.translate('lbl_prefer_leg'),
                context: context,
                value: filter?.leg,
                items: test
                    .map((key, value) {
                      return MapEntry(
                          key,
                          DropdownMenuItem(
                            value: key,
                            child: Text(value),
                          ));
                    })
                    .values
                    .toList(),
                onChanged: (value) => changePlayerFilter(leg: value),
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.translate('lbl_confirmed_by_us'),
                    style: textTheme.subtitle1
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  mawahebSwitchButton(
                    isSelected: filter.isConfirmed,
                    onChanged: (value) {
                      setState(() {
                        changePlayerFilter(isConfirmed: value);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.translate('lbl_booked_by_us'),
                      style: textTheme.subtitle1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                  mawahebSwitchButton(
                    isSelected: filter.isBooked,
                    onChanged: (value) {
                      setState(() {
                        changePlayerFilter(isBooked: value);
                      });
                    },
                  ),
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
                  widget.viewmodel.filter = filter;
                  widget.viewmodel
                      .searchPlayers(fresh: true, query: widget.query);
                  context.pop();
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void changePlayerFilter({
    CountryModel country,
    SportModel sport,
    SportPositionModel position,
    String hand,
    String leg,
    String name,
    int partnerId,
    bool isConfirmed,
    bool isBooked,
  }) {
    filter = filter.copyWith(
      country: country,
      sport: sport,
      position: position,
      hand: hand,
      leg: leg,
      name: name,
      partnerId: partnerId,
      isConfirmed: isConfirmed,
      isBooked: isBooked,
    );
  }
}
