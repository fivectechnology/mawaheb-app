import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/public_info/ui/widgets/download_row_widget.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key key}) : super(key: key);

  static const String route = '/contacts';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const ContactsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends MobxState<ContactsPage, PublicInfoViewmodel> {
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
