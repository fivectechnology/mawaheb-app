import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class PublicInfoPage extends StatefulWidget {
  const PublicInfoPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const PublicInfoPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _PublicInfoPageState createState() => _PublicInfoPageState();
}

class _PublicInfoPageState extends MobxState<PublicInfoPage, PublicInfoViewmodel> {
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
    return Container(color: RED);
  }
}
