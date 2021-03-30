import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const PlayersPage());

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends MobxState<PlayersPage, PlayersViewmodel> {
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
    return Container();
  }
}
