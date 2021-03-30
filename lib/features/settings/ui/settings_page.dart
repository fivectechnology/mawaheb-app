import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends MobxState<SettingsPage, SettingsViewmodel> {
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
    return Container(color: TEXT_COLOR);
  }
}
