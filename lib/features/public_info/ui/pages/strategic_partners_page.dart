import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/features/public_info/ui/widgets/download_row_widget.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class StrategicPartnersPage extends StatefulWidget {
  const StrategicPartnersPage({Key key}) : super(key: key);

  static const String route = '/strategic_partners';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const StrategicPartnersPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _StrategicPartnersPageState createState() => _StrategicPartnersPageState();
}

class _StrategicPartnersPageState
    extends MobxState<StrategicPartnersPage, PublicInfoViewmodel> {
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
        body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.07),
            itemCount: 3,
            itemBuilder: (context, index) {
              return imageRow(context: context);
            }));
  }
}
